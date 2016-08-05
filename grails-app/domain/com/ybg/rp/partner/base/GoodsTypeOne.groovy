package com.ybg.rp.partner.base

class GoodsTypeOne {

    static hasMany = [children: GoodsTypeTwo]

    static constraints = {

    }

    String name
    Short status
}
