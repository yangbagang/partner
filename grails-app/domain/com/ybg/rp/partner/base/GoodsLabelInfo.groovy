package com.ybg.rp.partner.base

class GoodsLabelInfo {

    static belongsTo = [goodsBaseInfo: GoodsBaseInfo, goodsLabel: GoodsTypeLabel]

    static constraints = {
    }
}
