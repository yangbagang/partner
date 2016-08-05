package com.ybg.rp.partner.device

class VendMachineInfoErrorInfo {

    static belongsTo = [vendMachine: VendMachineInfo]

    static constraints = {
        fixTime nullable: true
    }

    /** 轨道编号*/
    String orbitalNo;

    /** 创建时间*/
    Date createTime

    /** 更新时间*/
    Date fixTime

    /**
     * 错误信息
     */
    String errorInfo

    /** 修复状态0：修复，1：未修复*/
    Short status = 0

    transient String machineName
    transient String themeStoreName

    String getMachineName() {
        return vendMachine?.machineName
    }

    String getThemeStoreName() {
        return vendMachine?.themeStore?.name
    }
}
