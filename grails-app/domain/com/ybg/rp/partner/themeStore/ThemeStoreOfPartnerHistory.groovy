package com.ybg.rp.partner.themeStore

import com.ybg.rp.partner.partner.PartnerBaseInfo

class ThemeStoreOfPartnerHistory {

    static belongsTo = [baseInfo: ThemeStoreBaseInfo, partner: PartnerBaseInfo]

    static constraints = {

    }

    Float scale
    Date lastUpdateTime
}
