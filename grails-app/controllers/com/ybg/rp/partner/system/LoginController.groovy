package com.ybg.rp.partner.system

import com.ybg.rp.partner.partner.PartnerUserInfo
import com.ybg.rp.partner.utils.NetUtil
import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.authentication.encoding.BCryptPasswordEncoder
import grails.plugin.springsecurity.userdetails.NoStackUsernameNotFoundException
import org.apache.commons.lang.StringUtils
import org.springframework.security.core.context.SecurityContextHolder

class LoginController {

    /** spring 安全服务类*/
    def springSecurityService

    def jcaptchaService

    def jcaptchaLimitService

    def partnerUserLoginRecordService

    def index() {
        render(view: "login")
    }

    def form() {
        render(view: "login")
    }

    def validateAuthUser(PartnerUserInfo partnerUserInfoInstance) {
        def crypto = new BCryptPasswordEncoder(
                (int) SpringSecurityUtils.securityConfig.password.bcrypt.logrounds)
        def partnerUserInfo = PartnerUserInfo.findByUsernameAndEnabled(partnerUserInfoInstance.username, true)
        if (partnerUserInfo == null ||
                !crypto.isPasswordValid(partnerUserInfo.password, partnerUserInfoInstance.password, null)) {
            throw new NoStackUsernameNotFoundException()
        }
    }

    def authFail() {
        flash.message = "登录失败,用户不存在或密码错。"
        redirect url: SpringSecurityUtils.securityConfig.auth.loginFormUrl
    }

    //登录处理
    def auth(PartnerUserInfo partnerUserInfoInstance) {
        ConfigObject jcaptcha = grailsApplication.config.jcaptcha
        if (jcaptcha.enabled) {
            if (!params.jcaptchaChallenge) {
                session.setAttribute(SpringSecurityUtils.SPRING_SECURITY_LAST_USERNAME_KEY, partnerUserInfoInstance.username)
                session.setAttribute('SPRING_SECURITY_LAST_PASSWORD', partnerUserInfoInstance.password)
                flash.message = "登录失败,验证码不能为空。"
                flash.errorTag = 1
                redirect url: SpringSecurityUtils.securityConfig.auth.loginFormUrl
                return
            }
            def jcaptchaName = jcaptcha.jcaptchaName as String
            if (!jcaptchaService.validateResponse(jcaptchaName,
                    session.id, params.jcaptchaChallenge)) {
                session.setAttribute(SpringSecurityUtils.SPRING_SECURITY_LAST_USERNAME_KEY, partnerUserInfoInstance.username)
                session.setAttribute('SPRING_SECURITY_LAST_PASSWORD', partnerUserInfoInstance.password)
                if (jcaptchaLimitService.failLogin(jcaptchaName)) {
                    flash.message = "登录失败,超过最大允许次数。"
                    redirect url: SpringSecurityUtils.securityConfig.auth.loginFormUrl
                    return
                }
                flash.message = "验证码错误。"
                flash.errorTag = 1
                redirect url: SpringSecurityUtils.securityConfig.auth.loginFormUrl
                return
            }
            jcaptchaLimitService.loginSuccess(jcaptchaName)
        }
        springSecurityService.clearCachedRequestmaps()
        if (StringUtils.isEmpty(partnerUserInfoInstance.username) ||
                StringUtils.isEmpty(partnerUserInfoInstance.password)) {
            session.setAttribute(SpringSecurityUtils.SPRING_SECURITY_LAST_USERNAME_KEY, '')
            session.setAttribute('SPRING_SECURITY_LAST_PASSWORD', '')
            flash.message = "用户名、密码不能为空。"
            flash.errorTag = 2
            redirect url: SpringSecurityUtils.securityConfig.auth.loginFormUrl
            return
        }
        if (!springSecurityService.isLoggedIn()) {
            try {
                validateAuthUser(partnerUserInfoInstance)
                springSecurityService.reauthenticate(partnerUserInfoInstance.username, partnerUserInfoInstance.password)
            } catch (Exception e) {
                e.printStackTrace()
                session.setAttribute(SpringSecurityUtils.SPRING_SECURITY_LAST_USERNAME_KEY, '')
                session.setAttribute('SPRING_SECURITY_LAST_PASSWORD', '')
                flash.errorTag = 2
                authFail()
                return
            }
            session.setAttribute(SpringSecurityUtils.SPRING_SECURITY_LAST_USERNAME_KEY, partnerUserInfoInstance.username)
        } else {
            try {
                validateAuthUser(partnerUserInfoInstance)
            } catch (Exception e) {
                session.setAttribute(SpringSecurityUtils.SPRING_SECURITY_LAST_USERNAME_KEY, '')
                session.setAttribute('SPRING_SECURITY_LAST_PASSWORD', '')
                flash.errorTag = 2
                authFail()
                return
            }
        }
        partnerUserLoginRecordService.addLoginLog(partnerUserInfoInstance, NetUtil.getUserIP(request))
        redirect uri: SpringSecurityUtils.securityConfig.successHandler.defaultTargetUrl
    }

    def logout() {
        SecurityContextHolder.clearContext()
        redirect action: 'form'
    }
}
