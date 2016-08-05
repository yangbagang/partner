package com.ybg.rp.partner.themeStore

import com.ybg.rp.partner.vo.AjaxPagingVo
import grails.converters.JSON
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ThemeStoreOfPartnerController {

    static allowedMethods = [save: "POST", delete: "DELETE"]

    def springSecurityService

    def index() {
        //render html for ajax
    }

    def list() {
        def data = ThemeStoreOfPartner.list(params)
        def count = ThemeStoreOfPartner.count()

        def result = new AjaxPagingVo()
        result.data = data
        result.draw = Integer.valueOf(params.draw)
        result.error = ""
        result.success = true
        result.recordsTotal = count
        result.recordsFiltered = count
        render result as JSON
    }

    def show(Long themeStoreId) {
        def themeStore = ThemeStoreBaseInfo.get(themeStoreId)
        def themeStoreOfPartner = ThemeStoreOfPartner.findByBaseInfo(themeStore)
        if (!themeStoreOfPartner) {
            themeStoreOfPartner = new ThemeStoreOfPartner()
            themeStoreOfPartner.baseInfo = themeStore
            themeStoreOfPartner.scale = 0
            themeStoreOfPartner.fromDate = new Date()
            themeStoreOfPartner.toDate = new Date()
        }
        render themeStoreOfPartner as JSON
    }

    @Transactional
    def save(ThemeStoreOfPartner themeStoreOfPartner) {
        def result = [:]
        if (themeStoreOfPartner == null) {
            result.success = false
            result.msg = "themeStoreOfPartner is null."
            render result as JSON
            return
        }

        def user = springSecurityService.currentUser
        themeStoreOfPartner.lastUpdateTime = new Date()
        themeStoreOfPartner.lastUpdateUser = user

        themeStoreOfPartner.save flush:true

        if (themeStoreOfPartner.hasErrors()) {
            transactionStatus.setRollbackOnly()
            result.success = false
            result.msg = themeStoreOfPartner.errors
            render result as JSON
            return
        }

        //add log
        def history = new ThemeStoreOfPartnerHistory()
        history.baseInfo = themeStoreOfPartner.baseInfo
        history.partner = themeStoreOfPartner.partner
        history.scale = themeStoreOfPartner.scale
        history.lastUpdateUser = themeStoreOfPartner.lastUpdateUser
        history.lastUpdateTime = themeStoreOfPartner.lastUpdateTime
        history.save flush: true

        result.success = true
        result.msg = ""
        render result as JSON
    }

    @Transactional
    def delete(Long themeStoreId) {
        def themeStore = ThemeStoreBaseInfo.get(themeStoreId)
        def themeStoreOfPartner = ThemeStoreOfPartner.findByBaseInfo(themeStore)
        def result = [:]
        if (themeStoreOfPartner == null) {
            result.success = false
            result.msg = "themeStoreOfPartner is null."
            render result as JSON
            return
        }

        themeStoreOfPartner.delete flush:true

        result.success = true
        result.msg = ""
        render result as JSON
    }

}
