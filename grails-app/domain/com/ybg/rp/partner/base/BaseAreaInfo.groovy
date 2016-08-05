package com.ybg.rp.partner.base

class BaseAreaInfo {

    static constraints = {

    }

    Short level
    String areaNo
    Integer pid
    String name

    transient String parentName

    String getParentName() {
        if (this.pid == 0) {
            ""
        } else {
            BaseAreaInfo.get(this.pid)?.name
        }
    }
}
