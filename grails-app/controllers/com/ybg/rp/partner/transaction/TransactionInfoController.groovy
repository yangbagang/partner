package com.ybg.rp.partner.transaction

import com.ybg.rp.partner.vo.AjaxPagingVo
import grails.converters.JSON
import grails.transaction.Transactional

@Transactional(readOnly = true)
class TransactionInfoController {

    static allowedMethods = [save: "POST", delete: "DELETE"]

    def index() {
        //render html for ajax
    }

    def list() {
        def data = TransactionInfo.list(params)
        def count = TransactionInfo.count()

        def result = new AjaxPagingVo()
        result.data = data
        result.draw = Integer.valueOf(params.draw)
        result.error = ""
        result.success = true
        result.recordsTotal = count
        result.recordsFiltered = count
        render result as JSON
    }

    def show(TransactionInfo transactionInfo) {
        render transactionInfo as JSON
    }

    @Transactional
    def save(TransactionInfo transactionInfo) {
        def result = [:]
        if (transactionInfo == null) {
            result.success = false
            result.msg = "transactionInfo is null."
            render result as JSON
            return
        }

        transactionInfo.save flush:true

        if (transactionInfo.hasErrors()) {
            transactionStatus.setRollbackOnly()
            result.success = false
            result.msg = transactionInfo.errors
            render result as JSON
            return
        }

        result.success = true
        result.msg = ""
        render result as JSON
    }

    @Transactional
    def delete(TransactionInfo transactionInfo) {
        def result = [:]
        if (transactionInfo == null) {
            result.success = false
            result.msg = "transactionInfo is null."
            render result as JSON
            return
        }

        transactionInfo.delete flush:true

        result.success = true
        result.msg = ""
        render result as JSON
    }

}
