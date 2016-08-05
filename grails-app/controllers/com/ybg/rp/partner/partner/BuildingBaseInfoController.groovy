package com.ybg.rp.partner.partner

import com.ybg.rp.partner.vo.AjaxPagingVo
import grails.converters.JSON
import grails.transaction.Transactional

@Transactional(readOnly = true)
class BuildingBaseInfoController {

    static allowedMethods = [save: "POST", delete: "DELETE"]

    def springSecurityService

    def index() {
        //render html for ajax
    }

    def list() {
        def data = BuildingBaseInfo.list(params)
        def count = BuildingBaseInfo.count()

        def result = new AjaxPagingVo()
        result.data = data
        result.draw = Integer.valueOf(params.draw)
        result.error = ""
        result.success = true
        result.recordsTotal = count
        result.recordsFiltered = count
        render result as JSON
    }

    def show(BuildingBaseInfo buildingBaseInfo) {
        render buildingBaseInfo as JSON
    }

    @Transactional
    def save(BuildingBaseInfo buildingBaseInfo) {
        def result = [:]
        if (buildingBaseInfo == null) {
            result.success = false
            result.msg = "buildingBaseInfo is null."
            render result as JSON
            return
        }

        def user = springSecurityService.currentUser
        if (!buildingBaseInfo.id) {
            buildingBaseInfo.admin = user
            buildingBaseInfo.uploadTime = new Date()
        }
        buildingBaseInfo.auditTime = new Date()

        println "buildingBaseInfo.partner.id=${buildingBaseInfo?.partner?.id}"

        if (buildingBaseInfo.hasErrors()) {
            buildingBaseInfo.errors.each {
                println it
            }
            transactionStatus.setRollbackOnly()
            result.success = false
            result.msg = buildingBaseInfo.errors
            render result as JSON
            return
        }

        buildingBaseInfo.save flush:true

        result.success = true
        result.msg = ""
        render result as JSON
    }

    @Transactional
    def delete(BuildingBaseInfo buildingBaseInfo) {
        def result = [:]
        if (buildingBaseInfo == null) {
            result.success = false
            result.msg = "buildingBaseInfo is null."
            render result as JSON
            return
        }

        buildingBaseInfo.delete flush:true

        result.success = true
        result.msg = ""
        render result as JSON
    }

}
