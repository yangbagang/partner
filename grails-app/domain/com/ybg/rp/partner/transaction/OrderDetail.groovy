package com.ybg.rp.partner.transaction

import com.ybg.rp.partner.device.VendLayerTrackGoods

class OrderDetail {

    static belongsTo = [order: OrderInfo]

    static constraints = {
        goodsPic nullable: true
    }

    VendLayerTrackGoods goods
    Integer goodsNum
    Float goodsPrice
    Float discount
    Float buyPrice
    String goodsName
    String goodsSpec
    String goodsPic
    String orbitalNo
    Integer status//0 未取货 1 申请退款 2 已退款 3取货
    Short errorStatus//异常状态:0-正常 1-异常 2-已处理  默认0
    Double refundPrice//退款金额

    transient String vmCode
    transient Date createTime
    transient String orderNo
    String getVmCode() {
        goods?.vendMachine?.machineCode
    }
    Date getCreateTime() {
        order?.createTime
    }
    String getOrderNo() {
        order?.orderNo
    }
}
