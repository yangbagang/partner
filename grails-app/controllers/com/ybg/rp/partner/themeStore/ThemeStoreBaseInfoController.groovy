package com.ybg.rp.partner.themeStore

import com.ybg.rp.partner.partner.BuildingBaseInfo
import com.ybg.rp.partner.vo.AjaxPagingVo
import grails.converters.JSON
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ThemeStoreBaseInfoController {

    static allowedMethods = [save: "POST", delete: "DELETE"]

    def index() {
        //render html for ajax
    }

    def list() {
        def data = ThemeStoreBaseInfo.list(params)
        def count = ThemeStoreBaseInfo.count()

        def result = new AjaxPagingVo()
        result.data = data
        result.draw = Integer.valueOf(params.draw)
        result.error = ""
        result.success = true
        result.recordsTotal = count
        result.recordsFiltered = count
        render result as JSON
    }

    @Transactional
    def show(Long buildingId) {
        def building = BuildingBaseInfo.get(buildingId)
        def themeStoreBaseInfo = ThemeStoreBaseInfo.findByBuilding(building)
        if (!themeStoreBaseInfo) {
            themeStoreBaseInfo = new ThemeStoreBaseInfo()
            themeStoreBaseInfo.building = building
            themeStoreBaseInfo.name = "${building?.name}主题店"
            themeStoreBaseInfo.province = building.province
            themeStoreBaseInfo.city = building.city
            themeStoreBaseInfo.county = building.county
            themeStoreBaseInfo.status = 0 as Short
            themeStoreBaseInfo.createTime = new Date()
            themeStoreBaseInfo.longitude = 0 as Double
            themeStoreBaseInfo.latitude = 0 as Double
            themeStoreBaseInfo.position = building.address
            themeStoreBaseInfo.save flush: true
        }
        render themeStoreBaseInfo as JSON
    }

    @Transactional
    def save(ThemeStoreBaseInfo themeStoreBaseInfo) {
        def result = [:]
        if (themeStoreBaseInfo == null) {
            result.success = false
            result.msg = "themeStoreBaseInfo is null."
            render result as JSON
            return
        }

        themeStoreBaseInfo.createTime = new Date()

        if (themeStoreBaseInfo.hasErrors()) {
            transactionStatus.setRollbackOnly()
            result.success = false
            result.msg = themeStoreBaseInfo.errors
            render result as JSON
            return
        }

        themeStoreBaseInfo.save flush:true

        result.success = true
        result.msg = ""
        render result as JSON
    }

    def listThemeStores() {
        //def result = ThemeStoreBaseInfo.findAllByStatus(1 as Short)
        def result = ThemeStoreBaseInfo.findAll()
        render result as JSON
    }
}
