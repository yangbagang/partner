package com.ybg.rp.partner.partner

import com.ybg.rp.partner.vo.AjaxPagingVo
import grails.converters.JSON
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PartnerBaseInfoController {

    static allowedMethods = [save: "POST", delete: "DELETE"]

    def springSecurityService

    def index() {
        //render html for ajax
    }

    def list() {
        def data = PartnerBaseInfo.list(params)
        def count = PartnerBaseInfo.count()

        def result = new AjaxPagingVo()
        result.data = data
        result.draw = Integer.valueOf(params.draw)
        result.error = ""
        result.success = true
        result.recordsTotal = count
        result.recordsFiltered = count
        render result as JSON
    }

    def show(PartnerBaseInfo partnerBaseInfo) {
        render partnerBaseInfo as JSON
    }

    @Transactional
    def save(PartnerBaseInfo partnerBaseInfo) {
        def result = [:]
        if (partnerBaseInfo == null) {
            result.success = false
            result.msg = "partnerBaseInfo is null."
            render result as JSON
            return
        }

        def user = springSecurityService.currentUser
        if (partnerBaseInfo.createTime == null) {
            println "init createTime"
            partnerBaseInfo.createTime = new Date()
        }
        println "createTime=${partnerBaseInfo.createTime}"

        partnerBaseInfo.auditTime = new Date()
        partnerBaseInfo.admin = user

        if (partnerBaseInfo.hasErrors()) {
            partnerBaseInfo.errors.each {
                println it
            }
            transactionStatus.setRollbackOnly()
            result.success = false
            result.msg = partnerBaseInfo.errors
            render result as JSON
            return
        }

        partnerBaseInfo.save flush:true

        result.success = true
        result.msg = ""
        render result as JSON
    }

    @Transactional
    def delete(PartnerBaseInfo partnerBaseInfo) {
        def result = [:]
        if (partnerBaseInfo == null) {
            result.success = false
            result.msg = "partnerBaseInfo is null."
            render result as JSON
            return
        }

        partnerBaseInfo.delete flush:true

        result.success = true
        result.msg = ""
        render result as JSON
    }

    def listPartners() {
        def result = PartnerBaseInfo.findAllByStatus(Short.valueOf("1"))
        render result as JSON
    }
}
