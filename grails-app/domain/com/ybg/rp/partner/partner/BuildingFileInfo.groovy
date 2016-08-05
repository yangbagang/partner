package com.ybg.rp.partner.partner

class BuildingFileInfo {

    static belongsTo = [building: BuildingBaseInfo]

    static constraints = {
    }

    String fileId
}
