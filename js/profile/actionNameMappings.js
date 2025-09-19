export const saveActionNameMap = {
    "AW": businessType => {
        if("IND" === businessType || "SPROP" === businessType) return "saveAirport1";
        else return "saveAirport2";
    },
    "BR": businessType => {
        if("IND" === businessType || "SPROP" === businessType) return "saveBroker1";
        else return "saveBroker2";
    },
    "CY": businessType => {
        if("IND" === businessType || "SPROP" === businessType) return "saveCYCFS1";
        else return "saveCYCFS2";
    },
    "IM": businessType => {
        if("IND" === businessType || "SPROP" === businessType) return "saveProfileImporter1";
        else return "saveProfileImporter2";
    },
    "EX": businessType => {
        if("IND" === businessType || "SPROP" === businessType) return "saveProfileExporter1";
        else return "saveProfileExporter2";
    },
    "SU": businessType => {
        if("IND" === businessType || "SPROP" === businessType) return "saveSurety1";
        else return "saveSurety2";
    },
    "WO": businessType => {
        if("IND" === businessType || "SPROP" === businessType) return "saveWarehouse1";
        else return "saveWarehouse2";
    },
    "YI": businessType => {
        if("IND" === businessType || "SPROP" === businessType) return "YI1save";
        else return "YI2save";
    },
    "AR": businessType => {
        if("IND" === businessType || "SPROP" === businessType) return "saveArrastreOperator1";
        else return "saveArrastreOperator2";
    },

};