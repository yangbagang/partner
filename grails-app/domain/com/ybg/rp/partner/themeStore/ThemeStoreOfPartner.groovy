package com.ybg.rp.partner.themeStore

import com.ybg.rp.partner.partner.PartnerBaseInfo
import grails.databinding.BindingFormat

class ThemeStoreOfPartner {

    static belongsTo = [baseInfo: ThemeStoreBaseInfo, partner: PartnerBaseInfo]

    static constraints = {
    }

    Float scale
    @BindingFormat("yyyy-MM-dd")
    Date fromDate
    @BindingFormat("yyyy-MM-dd")
    Date toDate
    Date lastUpdateTime

}
