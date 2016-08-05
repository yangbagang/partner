package com.ybg.rp.partner.base

class GoodsTypeInfo {

    static belongsTo = [goodsBaseInfo: GoodsBaseInfo, goodsTypeTwo: GoodsTypeTwo]

    static constraints = {
    }

    transient String goodsName
    transient String typeOneName
    transient String typeTwoName

    String getTypeOneName() {
        goodsTypeTwo?.typeOne?.name
    }

    String getTypeTwoName() {
        goodsTypeTwo?.name
    }

    String getGoodsName() {
        goodsBaseInfo?.name
    }
}
