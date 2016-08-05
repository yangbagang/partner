package com.ybg.rp.partner.objectMarshaller.partner

import com.ybg.rp.partner.partner.PartnerUserAuthority
import grails.converters.JSON
import org.grails.web.converters.exceptions.ConverterException
import org.grails.web.converters.marshaller.ObjectMarshaller
import org.grails.web.json.JSONWriter

/**
 * Created by yangbagang on 16/7/8.
 */
class PartnerUserAuthorityObjectMarshaller implements ObjectMarshaller<JSON>  {
    @Override
    boolean supports(Object object) {
        return object instanceof PartnerUserAuthority
    }

    @Override
    void marshalObject(Object object, JSON converter) throws ConverterException {
        JSONWriter writer = converter.getWriter()
        writer.object()
        writer.key('partnerName').value(object?.user?.parnterBaseInfo?.shortName)
              .key("userName").value(object?.user?.realName)
              .key('roleName').value(object?.authority?.name)
              .key('userId').value(object.user?.id)
              .key('roleId').value(object.authority?.id)
        writer.endObject()
    }
}
