package com.ybg.rp.partner.objectMarshaller.themeStore

import com.ybg.rp.partner.themeStore.ThemeStoreOfPartnerHistory
import grails.converters.JSON
import org.grails.web.converters.exceptions.ConverterException
import org.grails.web.converters.marshaller.ObjectMarshaller
import org.grails.web.json.JSONWriter

import java.text.SimpleDateFormat

/**
 * Created by yangbagang on 16/7/10.
 */
class ThemeStoreOfPartnerHistoryObjectMarshaller implements ObjectMarshaller<JSON>  {

    def sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")

    @Override
    boolean supports(Object object) {
        return object instanceof ThemeStoreOfPartnerHistory
    }

    @Override
    void marshalObject(Object object, JSON converter) throws ConverterException {
        JSONWriter writer = converter.getWriter()
        writer.object()
        writer.key('id').value(object.id)
              .key('themeStoreName').value(object.baseInfo.name)
              .key("partnerName").value(object.partner.shortName)
              .key('scale').value(object.scale)
              .key('operator').value(object.lastUpdateUser.realName)
              .key('operationTime').value(sdf?.format(object.lastUpdateTime))
        writer.endObject()
    }

}
