package com.ybg.rp.partner.base

class GoodsTypeLabel {

    static hasMany = [goodsInfos: GoodsLabelInfo]

    static constraints = {

    }

    String label
    Short status

}
