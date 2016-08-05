package com.ybg.rp.partner.base

class GoodsBaseInfo {

    static hasMany = [labels: GoodsLabelInfo, types: GoodsTypeInfo]

    static constraints = {
        picId nullable: true
    }

    String name
    String brand
    String specifications
    Float basePrice
    String picId
    String letter

    String toString() {
        return "${brand}-${name}-${specifications}"
    }
}
