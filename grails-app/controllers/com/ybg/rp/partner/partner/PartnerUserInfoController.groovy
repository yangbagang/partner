package com.ybg.rp.partner.partner

import com.ybg.rp.partner.vo.AjaxPagingVo
import grails.converters.JSON
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PartnerUserInfoController {

    static allowedMethods = [save: "POST", delete: "DELETE"]

    def springSecurityService

    def index() {
        //render html for ajax
    }

    def list() {
        def data = PartnerUserInfo.list(params)
        def count = PartnerUserInfo.count()

        def result = new AjaxPagingVo()
        result.data = data
        result.draw = Integer.valueOf(params.draw)
        result.error = ""
        result.success = true
        result.recordsTotal = count
        result.recordsFiltered = count
        render result as JSON
    }

    def show(PartnerUserInfo partnerUserInfo) {
        render partnerUserInfo as JSON
    }

    @Transactional
    def save(PartnerUserInfo partnerUserInfo) {
        def result = [:]
        if (partnerUserInfo == null) {
            result.success = false
            result.msg = "partnerUserInfo is null."
            render result as JSON
            return
        }

        def user = springSecurityService.currentUser
        if (!partnerUserInfo.id) {
            def now = new Date()
            partnerUserInfo.createTime = now
            partnerUserInfo.updateTime = now
            partnerUserInfo.createUser = user.realName
            partnerUserInfo.updateUser = user.realName
        } else {
            partnerUserInfo.updateTime = new Date()
            partnerUserInfo.updateUser = user.realName
        }

        if ("1" == params.enableAccount) {
            partnerUserInfo.enabled = true
        } else {
            partnerUserInfo.enabled = false
        }

        if (partnerUserInfo.hasErrors()) {
            transactionStatus.setRollbackOnly()
            result.success = false
            result.msg = partnerUserInfo.errors
            render result as JSON
            return
        }

        partnerUserInfo.save flush:true

        result.success = true
        result.msg = ""
        render result as JSON
    }

    @Transactional
    def delete(PartnerUserInfo partnerUserInfo) {
        def result = [:]
        if (partnerUserInfo == null) {
            result.success = false
            result.msg = "partnerUserInfo is null."
            render result as JSON
            return
        }

        partnerUserInfo.delete flush:true

        result.success = true
        result.msg = ""
        render result as JSON
    }

    def listPartnerUsers() {
        def result = PartnerUserInfo.findAllByEnabled(true)
        render result as JSON
    }
}
