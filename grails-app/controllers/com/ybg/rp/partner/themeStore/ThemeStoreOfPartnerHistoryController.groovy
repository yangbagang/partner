package com.ybg.rp.partner.themeStore

import com.ybg.rp.partner.vo.AjaxPagingVo
import grails.converters.JSON
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ThemeStoreOfPartnerHistoryController {

    def index() {
        //render html for ajax
    }

    def list() {
        def data = ThemeStoreOfPartnerHistory.list(params)
        def count = ThemeStoreOfPartnerHistory.count()

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
