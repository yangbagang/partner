package com.ybg.rp.partner.transaction

import com.ybg.rp.partner.vo.AjaxPagingVo
import grails.converters.JSON
import grails.transaction.Transactional

@Transactional(readOnly = true)
class OrderInfoController {

    static allowedMethods = [save: "POST", delete: "DELETE"]

    def index() {
        //render html for ajax
    }

    def list() {
        def data = OrderInfo.list(params)
        def count = OrderInfo.count()

        def result = new AjaxPagingVo()
        result.data = data
        result.draw = Integer.valueOf(params.draw)
        result.error = ""
        result.success = true
        result.recordsTotal = count
        result.recordsFiltered = count
        render result as JSON
    }

    def show(OrderInfo orderInfo) {
        render orderInfo as JSON
    }

    @Transactional
    def save(OrderInfo orderInfo) {
        def result = [:]
        if (orderInfo == null) {
            result.success = false
            result.msg = "orderInfo is null."
            render result as JSON
            return
        }

        orderInfo.save flush:true

        if (orderInfo.hasErrors()) {
            transactionStatus.setRollbackOnly()
            result.success = false
            result.msg = orderInfo.errors
            render result as JSON
            return
        }

        result.success = true
        result.msg = ""
        render result as JSON
    }

    @Transactional
    def delete(OrderInfo orderInfo) {
        def result = [:]
        if (orderInfo == null) {
            result.success = false
            result.msg = "orderInfo is null."
            render result as JSON
            return
        }

        orderInfo.delete flush:true

        result.success = true
        result.msg = ""
        render result as JSON
    }

}
