package com.ybg.rp.partner.transaction

import com.ybg.rp.partner.vo.AjaxPagingVo
import grails.converters.JSON
import grails.transaction.Transactional

@Transactional(readOnly = true)
class OrderDetailController {

    static allowedMethods = [save: "POST", delete: "DELETE"]

    def index() {
        //render html for ajax
    }

    def list() {
        def data = OrderDetail.list(params)
        def count = OrderDetail.count()

        def result = new AjaxPagingVo()
        result.data = data
        result.draw = Integer.valueOf(params.draw)
        result.error = ""
        result.success = true
        result.recordsTotal = count
        result.recordsFiltered = count
        render result as JSON
    }

    def show(OrderDetail orderDetail) {
        render orderDetail as JSON
    }

    @Transactional
    def save(OrderDetail orderDetail) {
        def result = [:]
        if (orderDetail == null) {
            result.success = false
            result.msg = "orderDetail is null."
            render result as JSON
            return
        }

        orderDetail.save flush:true

        if (orderDetail.hasErrors()) {
            transactionStatus.setRollbackOnly()
            result.success = false
            result.msg = orderDetail.errors
            render result as JSON
            return
        }

        result.success = true
        result.msg = ""
        render result as JSON
    }

    @Transactional
    def delete(OrderDetail orderDetail) {
        def result = [:]
        if (orderDetail == null) {
            result.success = false
            result.msg = "orderDetail is null."
            render result as JSON
            return
        }

        orderDetail.delete flush:true

        result.success = true
        result.msg = ""
        render result as JSON
    }

}
