package com.ybg.rp.partner.partner

import com.ybg.rp.partner.vo.AjaxPagingVo
import grails.converters.JSON
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PartnerUserAuthorityController {

    static allowedMethods = [save: "POST", delete: "DELETE"]

    def index() {
        //render html for ajax
    }

    def list() {
        def data = PartnerUserAuthority.list(params)
        def count = PartnerUserAuthority.count()

        def result = new AjaxPagingVo()
        result.data = data
        result.draw = Integer.valueOf(params.draw)
        result.error = ""
        result.success = true
        result.recordsTotal = count
        result.recordsFiltered = count
        render result as JSON
    }

    def show(PartnerUserAuthority partnerUserAuthority) {
        render partnerUserAuthority as JSON
    }

    @Transactional
    def addUserRole(Long userId) {
        def result = [:]

        if (userId && params.roleList) {
            for(String roleId in params.roleList) {
                if(!PartnerUserAuthority.exists(userId, Long.valueOf(roleId))) {
                    PartnerUserAuthority.create(userId, Long.valueOf(roleId))
                }
            }
        }

        result.success = true
        result.msg = ""
        render result as JSON
    }

    @Transactional
    def delete(Long userId, Long roleId) {
        def result = [:]
        def partnerUserAuthority = PartnerUserAuthority.get(userId, roleId)
        if (partnerUserAuthority == null) {
            result.success = false
            result.msg = "partnerUserAuthority is null."
            render result as JSON
            return
        }

        partnerUserAuthority.delete flush:true

        result.success = true
        result.msg = ""
        render result as JSON
    }

}
