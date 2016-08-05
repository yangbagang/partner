package com.ybg.rp.partner.themeStore

import com.ybg.rp.partner.base.GoodsTypeLabel

class ThemeStoreGoodsLabel {

    static belongsTo = [goodsInfo: ThemeStoreGoodsInfo, goodsLabel: GoodsTypeLabel]

    static constraints = {
    }

    static ThemeStoreGoodsLabel createInstance(ThemeStoreGoodsInfo goodsInfo, GoodsTypeLabel goodsTypeLabel) {
        def instance = new ThemeStoreGoodsLabel(goodsInfo: goodsInfo, goodsTypeLabel: goodsTypeLabel)
        instance.save flush: true
        instance
    }
}
