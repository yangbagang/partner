package com.ybg.rp.partner.security

import grails.plugin.springsecurity.userdetails.GrailsUser
import org.springframework.security.core.GrantedAuthority

/**
 * Created by yangbagang on 16/7/6.
 */
class PartnerUserDetails extends GrailsUser {

    final String realName

    PartnerUserDetails(String username, String password, boolean enabled,
                       boolean accountNonExpired, boolean credentialsNonExpired,
                       boolean accountNonLocked, Collection<GrantedAuthority> authorities,
                       long id, String realName) {
        super(username, password, enabled,
                accountNonExpired, credentialsNonExpired, accountNonLocked,
                authorities, id)
        this.realName = realName
    }
}
