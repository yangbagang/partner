package com.ybg.rp.partner.partner

import com.ybg.rp.partner.vo.AjaxPagingVo
import grails.converters.JSON
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PartnerAuthorityInfoController {

    static allowedMethods = [save: "POST", delete: "DELETE"]

    def index() {
        //render html for ajax
    }

    def list() {
        def data = PartnerAuthorityInfo.list(params)
        def count = PartnerAuthorityInfo.count()

        def result = new AjaxPagingVo()
        result.data = data
        result.draw = Integer.valueOf(params.draw)
        result.error = ""
        result.success = true
        result.recordsTotal = count
        result.recordsFiltered = count
        render result as JSON
    }

    def show(PartnerAuthorityInfo partnerAuthorityInfo) {
        render partnerAuthorityInfo as JSON
    }

    @Transactional
    def save(PartnerAuthorityInfo partnerAuthorityInfo) {
        def result = [:]
        if (partnerAuthorityInfo == null) {
            result.success = false
            result.msg = "partnerAuthorityInfo is null."
            render result as JSON
            return
        }

        if (partnerAuthorityInfo.hasErrors()) {
            transactionStatus.setRollbackOnly()
            result.success = false
            result.msg = partnerAuthorityInfo.errors
            render result as JSON
            return
        }

        partnerAuthorityInfo.save flush:true

        result.success = true
        result.msg = ""
        render result as JSON
    }

    @Transactional
    def delete(PartnerAuthorityInfo partnerAuthorityInfo) {
        def result = [:]
        if (partnerAuthorityInfo == null) {
            result.success = false
            result.msg = "partnerAuthorityInfo is null."
            render result as JSON
            return
        }

        partnerAuthorityInfo.delete flush:true

        result.success = true
        result.msg = ""
        render result as JSON
    }

    def listPartnerAuthoritys() {
        def result = PartnerAuthorityInfo.listOrderById()
        render result as JSON
    }
}
