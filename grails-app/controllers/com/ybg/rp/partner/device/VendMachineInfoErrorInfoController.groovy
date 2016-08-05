package com.ybg.rp.partner.device

import com.ybg.rp.partner.vo.AjaxPagingVo
import grails.converters.JSON
import grails.transaction.Transactional

@Transactional(readOnly = true)
class VendMachineInfoErrorInfoController {

    def index() {
        //render html for ajax
    }

    def list() {
        def data = VendMachineInfoErrorInfo.list(params)
        def count = VendMachineInfoErrorInfo.count()

        def result = new AjaxPagingVo()
        result.data = data
        result.draw = Integer.valueOf(params.draw)
        result.error = ""
        result.success = true
        result.recordsTotal = count
        result.recordsFiltered = count
        render result as JSON
    }

}
