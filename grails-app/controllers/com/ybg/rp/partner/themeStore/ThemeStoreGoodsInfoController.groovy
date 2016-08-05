package com.ybg.rp.partner.themeStore

import com.ybg.rp.partner.base.*
import com.ybg.rp.partner.vo.AjaxPagingVo
import grails.converters.JSON
import grails.gorm.DetachedCriteria
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ThemeStoreGoodsInfoController {

    static allowedMethods = [save: "POST", delete: "DELETE"]

    def index() {
        //render html for ajax
    }

    def list(Long themeStoreId) {
        if (themeStoreId == null) {
            themeStoreId = 1
        }
        def c = new DetachedCriteria(ThemeStoreGoodsInfo).build{
            eq "themeStore.id", themeStoreId
        }
        def d = c.list(params)
        def data = d
        def count = d.size()

        def result = new AjaxPagingVo()
        result.data = data
        result.draw = Integer.valueOf(params.draw)
        result.error = ""
        result.success = true
        result.recordsTotal = count
        result.recordsFiltered = count
        render result as JSON
    }

    def show(ThemeStoreGoodsInfo themeStoreGoodsInfo) {
        render themeStoreGoodsInfo as JSON
    }

    @Transactional
    def save(ThemeStoreGoodsInfo themeStoreGoodsInfo) {
        def result = [:]
        if (themeStoreGoodsInfo == null) {
            result.success = false
            result.msg = "themeStoreGoodsInfo is null."
            render result as JSON
            return
        }

        themeStoreGoodsInfo.save flush:true

        if (themeStoreGoodsInfo.hasErrors()) {
            transactionStatus.setRollbackOnly()
            result.success = false
            result.msg = themeStoreGoodsInfo.errors
            render result as JSON
            return
        }

        result.success = true
        result.msg = ""
        render result as JSON
    }

    @Transactional
    def delete(ThemeStoreGoodsInfo themeStoreGoodsInfo) {
        def result = [:]
        if (themeStoreGoodsInfo == null) {
            result.success = false
            result.msg = "themeStoreGoodsInfo is null."
            render result as JSON
            return
        }

        themeStoreGoodsInfo.delete flush:true

        result.success = true
        result.msg = ""
        render result as JSON
    }

    @Transactional
    def importGoods(Long themeStoreId) {
        println "themeStoreId=${params.themeStoreId}"
        def result = [:]

        try {
            def themeStore = ThemeStoreBaseInfo.get(themeStoreId)
            if (themeStore && params.goodsIds) {
                for (String goodsId in params.goodsIds) {
                    def g = ThemeStoreGoodsInfo.findAllByThemeStoreAndBaseId(themeStore, Long.valueOf(goodsId))
                    if (g?.size() > 0) {
                        continue
                    } else {
                        //create a instance
                        def themeStoreGoodsInfo = new ThemeStoreGoodsInfo()
                        def goods = GoodsBaseInfo.get(Long.valueOf(goodsId))
                        themeStoreGoodsInfo.themeStore = themeStore
                        themeStoreGoodsInfo.baseId = goods.id
                        themeStoreGoodsInfo.name = goods.name
                        themeStoreGoodsInfo.brand = goods.brand
                        themeStoreGoodsInfo.specifications = goods.specifications
                        themeStoreGoodsInfo.basePrice = goods.basePrice
                        themeStoreGoodsInfo.realPrice = goods.basePrice
                        themeStoreGoodsInfo.picId = goods.picId
                        themeStoreGoodsInfo.letter = goods.letter
                        themeStoreGoodsInfo.status = 1 as Short
                        themeStoreGoodsInfo.px = 1//to be modify
                        themeStoreGoodsInfo.save flush: true
                        //copy labels
                        def labels = GoodsLabelInfo.findAllByGoodsBaseInfo(goods)*.goodsLabel
                        for (GoodsTypeLabel label : labels) {
                            ThemeStoreGoodsLabel.createInstance(themeStoreGoodsInfo, label)
                        }
                        //copy types
                        def types = GoodsTypeInfo.findAllByGoodsBaseInfo(goods)*.goodsTypeTwo
                        for (GoodsTypeTwo typeTwo : types) {
                            ThemeStoreGoodsTypeTwo.createInstance(themeStoreGoodsInfo, typeTwo)
                            ThemeStoreGoodsTypeOne.createInstance(themeStoreGoodsInfo, typeTwo.typeOne)
                        }
                    }
                }
            }
        } catch (Exception e) {
        }

        result.success = true
        result.msg = ""
        render result as JSON
    }
}
