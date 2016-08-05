import com.ybg.rp.partner.objectMarshaller.partner.PartnerUserAuthorityObjectMarshaller
import com.ybg.rp.partner.objectMarshaller.themeStore.ThemeStoreOfPartnerHistoryObjectMarshaller
import grails.converters.JSON

class BootStrap {

    def init = { servletContext ->
        JSON.registerObjectMarshaller(Date) {
            return it?.format("yyyy-MM-dd HH:mm:ss")
        }
        JSON.registerObjectMarshaller(new PartnerUserAuthorityObjectMarshaller(), 9999)
        JSON.registerObjectMarshaller(new ThemeStoreOfPartnerHistoryObjectMarshaller(), 9999)
    }
    def destroy = {
    }
}
