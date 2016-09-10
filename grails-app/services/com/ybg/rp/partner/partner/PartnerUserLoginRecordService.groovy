package com.ybg.rp.partner.partner

import grails.transaction.Transactional

@Transactional
class PartnerUserLoginRecordService {

    def addLoginLog(PartnerUserInfo userInfo, String ip) {
        def loginRecord = new PartnerUserLoginRecord()
        loginRecord.userInfo = PartnerUserInfo.get(userInfo.id)
        loginRecord.loginTime = new Date()
        loginRecord.loginDevice = "web"
        loginRecord.loginIp = ip
        loginRecord.token = ""
        loginRecord.save flush: true
    }
}
