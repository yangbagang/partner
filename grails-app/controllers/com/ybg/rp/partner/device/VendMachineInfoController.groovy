package com.ybg.rp.partner.device

import com.ybg.rp.partner.themeStore.ThemeStoreBaseInfo
import com.ybg.rp.partner.vo.AjaxPagingVo
import grails.converters.JSON
import grails.transaction.Transactional

@Transactional(readOnly = true)
class VendMachineInfoController {

    static allowedMethods = [save: "POST", delete: "DELETE"]

    def index() {
        //render html for ajax
    }

    def list(Long themeStoreId) {
        if (!themeStoreId) {
            themeStoreId = 1
        }
        def themeStore = ThemeStoreBaseInfo.get(themeStoreId)
        def data = VendMachineInfo.findAllByThemeStore(themeStore)
        def count = data.size()

        def result = new AjaxPagingVo()
        result.data = data
        result.draw = Integer.valueOf(params.draw)
        result.error = ""
        result.success = true
        result.recordsTotal = count
        result.recordsFiltered = count
        render result as JSON
    }

    def show(VendMachineInfo vendMachineInfo) {
        render vendMachineInfo as JSON
    }

    @Transactional
    def save(VendMachineInfo vendMachineInfo) {
        def result = [:]
        if (vendMachineInfo == null) {
            result.success = false
            result.msg = "vendMachineInfo is null."
            render result as JSON
            return
        }

        vendMachineInfo.save flush:true

        if (vendMachineInfo.hasErrors()) {
            transactionStatus.setRollbackOnly()
            result.success = false
            result.msg = vendMachineInfo.errors
            render result as JSON
            return
        }

        result.success = true
        result.msg = ""
        render result as JSON
    }

    @Transactional
    def delete(VendMachineInfo vendMachineInfo) {
        def result = [:]
        if (vendMachineInfo == null) {
            result.success = false
            result.msg = "vendMachineInfo is null."
            render result as JSON
            return
        }

        vendMachineInfo.status = 0
        vendMachineInfo.save flush:true

        result.success = true
        result.msg = ""
        render result as JSON
    }

    def list2() {

    }

    def listOfflineDev() {
        def c = VendMachineInfo.createCriteria()
        def data = c.list(params) {
            and {
                eq("isReal", 1 as Short)
                eq("status", 1 as Short)
                or{
                    eq("onlineStatus", 0 as Short)
                    isNull("onlineStatus")
                }
            }
        }
        def count = data.size()

        def result = new AjaxPagingVo()
        result.data = data
        result.draw = Integer.valueOf(params.draw)
        result.error = ""
        result.success = true
        result.recordsTotal = data.totalCount
        result.recordsFiltered = count
        render result as JSON
    }
}
