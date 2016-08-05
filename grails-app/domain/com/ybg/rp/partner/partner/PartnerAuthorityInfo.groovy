package com.ybg.rp.partner.partner

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@EqualsAndHashCode(includes='authority')
@ToString(includes='authority', includeNames=true, includePackage=false)
class PartnerAuthorityInfo implements Serializable {

    static constraints = {

    }

    String authority
    String name
    String mem

    static hasMany = [partnerUserAuthorities: PartnerUserAuthority]
}
