package com.ybg.rp.partner.partner

import grails.databinding.BindingFormat

class PartnerBaseInfo {

    static constraints = {
        auditTime nullable: true
        createTime nullable: true
        pid nullable: true
        type nullable: true
    }

    String companyName
    String shortName
    String companyCode
    @BindingFormat("yyyy-MM-dd")
    Date bornDate
    Float registMoney
    String phoneNum
    String province
    String city
    String county
    String address
    String contactName
    String contactPhone
    String contactMail
    Date createTime
    Short status
    String bankName
    String accountName
    String accountNum
    Date auditTime
    Long pid = 0
    Short type = 0

    transient String tuiJianName

    String getTuiJianName() {
        if(pid == 0) {
            ""
        } else {
            def tuiJian = PartnerBaseInfo.get(pid)
            if (tuiJian) {
                tuiJian.shortName
            } else {
                ""
            }
        }
    }
}
