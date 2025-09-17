/**
 * The following are the map of fields displayed on form per ClientType and per BusinessType.
 * The values inside each map are the ids contained in ftl file (or what will be rendered in html in runtime).
 **/
let mainFieldMap = new Map;
let mainReqFieldMap = new Map;
let allFieldsList = new Set;

let ARMap = new Map;
let ARReqMap = new Map;

let WOMap = new Map;
let WOReqMap =  new Map;

let AWMap = new Map;
let AWReqMap = new Map;

let CYMap = new Map;
let CYReqMap = new Map;

let SUMap = new Map;
let SUReqMap = new Map;

let IMMap = new Map;
let IMReqMap = new Map;

let BRMap = new Map;
let BRReqMap = new Map;

let EXMap = new Map;
let EXReqMap = new Map;

let YIMap = new Map;
let YIReqMap = new Map;

mainFieldMap.set("AR", ARMap);
mainReqFieldMap.set("AR",ARReqMap);
mainFieldMap.set("WO", WOMap);
mainReqFieldMap.set("WO", WOReqMap);
mainFieldMap.set("AW", AWMap);
mainReqFieldMap.set("AW", AWReqMap);
mainFieldMap.set("CY", CYMap);
mainReqFieldMap.set("CY", CYReqMap);
mainFieldMap.set("SU", SUMap);
mainReqFieldMap.set("SU", SUReqMap);
mainFieldMap.set("IM", IMMap);
mainReqFieldMap.set("IM", IMReqMap);
mainFieldMap.set("BR", BRMap);
mainReqFieldMap.set("BR", BRReqMap);
mainFieldMap.set("EX", EXMap);
mainReqFieldMap.set("EX", EXReqMap);
mainFieldMap.set("YI", YIMap);
mainReqFieldMap.set("YI", YIReqMap);

/**
 * Arrastre Operator Map (AR)
 */

//COMPANY
ARMap.set("CMP", [
    //add unique fields for AR-COMP clients here
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount",
]);

//CORPORATION
ARMap.set("CORP", [
    //add unique fields for AR-CORP clients here
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount",
]);

//PARTNERSHIP
ARMap.set("PART", [
    //add unique fields for AR-PART clients here
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount",

]);

//INDIVIDUAL
ARMap.set("IND", [
    //add unique fields for AR-IND clients here
    "firstName",
    "middleName",
    "lastName"
]);

//SOLE PROPRIETOR
ARMap.set("SPROP", [
    //add unique fields for AR-SPROP clients here
    "firstName",
    "middleName",
    "lastName"
]);

//COMMON
ARMap.set("common-fields", [
    "clientType",
    "businessEntityType",
    "businessNature",
    "insClientNo",
    "companyName",
    "citizenship",
    "address",
    "city",
    "zipCode",
    "country",
    "telNo",
    "altTelNo",
    "fax",
    "mobileNo",
    "email",
    "website",
    "tinNo",
    "sssNo",
    "passportNo",
    "driverLicenseNo",
    "prcIdNo",
    "primaryVASPNo",
    "secondaryVASPNo",
    "uniqueRefNo",
    "relatedCompany1",
    "relatedCompany2",
    "relatedCompany3"
]);

// ****map required fields here****


//COMPANY
ARReqMap.set("CMP", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

//CORPORATION
ARReqMap.set("CORP", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

//PARTNERSHIP
ARReqMap.set("PART", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

//INDIVIDUAL
ARReqMap.set("IND", [
    //add unique fields for AR-IND clients here
    "firstName",
    "middleName",
    "lastName"
]);

//SOLE PROPRIETOR
ARReqMap.set("SPROP", [
    //add unique fields for AR-SPROP clients here
    "firstName",
    "middleName",
    "lastName"
]);

//COMMON
ARReqMap.set("common-fields", [
    "businessEntityType",
    "businessNature",
    "insClientNo",
    "companyName",
    "citizenship",
    "address",
    "city",
    "zipCode",
    "country",
    "telNo",
    "email",
    "tinNo",
    "primaryVASPNo"
]);

/**
 * Arrastre Operator Map END
 */


/**
 * Airport Warehouse (AW)
 * */

AWMap.set("common-fields", [
    "clientType",
    "businessEntityType",
    "businessNature",
    "insClientNo",
    "companyName",
    "citizenship",
    "address",
    "city",
    "zipCode",
    "country",
    "telNo",
    "altTelNo",
    "fax",
    "mobileNo",
    "email",
    "website",
    "bondedWarehouseType",
    "tinNo",
    "sssNo",
    "passportNo",
    "driverLicenseNo",
    "prcIdNo",
    "primaryVASPNo",
    "secondaryVASPNo",
    "uniqueRefNo",
    "relatedCompany1",
    "relatedCompany2",
    "relatedCompany3"

]);

AWMap.set("PART", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

AWMap.set("CORP", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

AWMap.set("CMP", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

AWMap.set("SPROP", [
    "firstName",
    "middleName",
    "lastName"
]);

AWMap.set("IND", [
    "firstName",
    "middleName",
    "lastName"
]);

// ****map required fields here****

AWReqMap.set("common-fields", [
    "clientType",
    "businessEntityType",
    "businessNature",
    "insClientNo",
    "companyName",
    "citizenship",
    "address",
    "city",
    "zipCode",
    "country",
    "telNo",
    "email",
    "bondedWarehouseType",
    "tinNo",
    "primaryVASPNo"
]);

AWReqMap.set("PART", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

AWReqMap.set("CORP", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

AWReqMap.set("CMP", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

AWReqMap.set("SPROP", [
    "firstName",
    "middleName",
    "lastName"
]);

AWReqMap.set("IND", [
    "firstName",
    "middleName",
    "lastName"
]);


/**
 * Airport Warehouse (AW) end
 * */


/**
 * Broker (BR)
 * */
BRMap.set("common-fields",[
    "clientType",
    "businessEntityType",
    "businessNature",
    "insClientNo",
    "companyName",
    "citizenship",
    "address",
    "city",
    "zipCode",
    "country",
    "telNo",
    "altTelNo",
    "fax",
    "mobileNo",
    "email",
    "website",
    "tinNo",
    "sssNo",
    "passportNo",
    "driverLicenseNo",
    "prcIdNo",
    "primaryVASPNo",
    "secondaryVASPNo",
    "relatedCompany1",
    "relatedCompany2",
    "relatedCompany3"

]);

BRMap.set("PART", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

BRMap.set("IND", [
    "firstName",
    "middleName",
    "lastName"
]);

BRMap.set("SPROP", [
    "firstName",
    "middleName",
    "lastName"
]);


BRReqMap.set("common-fields",[
    "clientType",
    "businessEntityType",
    "businessNature",
    "insClientNo",
    "companyName",
    "citizenship",
    "address",
    "city",
    "zipCode",
    "country",
    "telNo",
    "email",
    "tinNo",
    "sssNo",
    "prcIdNo",
    "primaryVASPNo"
]);

BRReqMap.set("PART", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

BRReqMap.set("IND", [
    "firstName",
    "middleName",
    "lastName"
]);

BRReqMap.set("SPROP", [
    "firstName",
    "middleName",
    "lastName"
]);


/**
 * Broker (BR) end
 * */


/**
 * CY-CFS Operator (CY)
 * */
CYMap.set("common-fields", [
    "bondedWarehouseType",
    "sssNo",
    "passportNo",
    "driverLicenseNo",
    "prcIdNo",
    "uniqueRefNo",
    "relatedCompany1",
    "relatedCompany2",
    "relatedCompany3"

]);

CYMap.set("PART", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

CYMap.set("CORP", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

CYMap.set("CMP", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);


CYReqMap.set("common-fields", [
    "bondedWarehouseType"
]);

CYReqMap.set("PART", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

CYReqMap.set("CORP", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

CYReqMap.set("CMP", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);
/**
 * CY-CFS Operator (CY) end
 * */


/**
 * Exporter (EX)
 * */
EXMap.set("common-fields", [
    "clientType",
    "businessEntityType",
    "businessNature",
    "insClientNo",
    "companyName",
    "citizenship",
    "address",
    "city",
    "zipCode",
    "country",
    "telNo",
    "altTelNo",
    "fax",
    "mobileNo",
    "email",
    "website",
    "tinNo",
    "sssNo",
    "passportNo",
    "driverLicenseNo",
    "prcIdNo",
    "primaryVASPNo",
    "secondaryVASPNo",
    "uniqueRefNo",
    "primaryBrokerTIN",
    "primaryBrokerCCN",
    "secondaryBrokerTIN",
    "secondaryBrokerCCN",
    "aabAssignedBankRefNo",
    "relatedCompany1",
    "relatedCompany2",
    "relatedCompany3"

]);

EXMap.set("PART", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

EXMap.set("CORP", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

EXMap.set("CMP", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

EXMap.set("IND",[
    "firstName",
    "middleName",
    "lastName"
]);


EXMap.set("SPROP",[
    "firstName",
    "middleName",
    "lastName"
]);


// *****map required fields here****
EXReqMap.set("common-fields",[
    "clientType",
    "businessEntityType",
    "businessNature",
    "insClientNo",
    "companyName",
    "citizenship",
    "address",
    "city",
    "zipCode",
    "country",
    "telNo",
    "email",
    "tinNo",
    "primaryVASPNo",
    "uniqueRefNo",
    "primaryBrokerTIN",
    "primaryBrokerCCN",
    "uniqueRefNo"
]);

EXReqMap.set("PART", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

EXReqMap.set("CORP", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

EXReqMap.set("CMP", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

EXReqMap.set("IND",[
    "firstName",
    "middleName",
    "lastName"
]);


EXReqMap.set("SPROP",[
    "firstName",
    "middleName",
    "lastName"
]);

/**
 * Exporter (EX) end
 * */


/**
 * Importer (IM)
 * */
IMMap.set("common-fields", [
    "clientType",
    "businessEntityType",
    "insClientNo",
    "businessNature",
    "companyName",
    "citizenship",
    "address",
    "city",
    "zipCode",
    "country",
    "telNo",
    "altTelNo",
    "fax",
    "mobileNo",
    "email",
    "website",
    "bondedWarehouse",
    "tinNo",
    "sssNo",
    "passportNo",
    "driverLicenseNo",
    "prcIdNo",
    "primaryVASPNo",
    "secondaryVASPNo",
    "uniqueRefNo",
    "primaryBrokerTIN",
    "primaryBrokerCCN",
    "secondaryBrokerTIN",
    "secondaryBrokerCCN",
    "aabAssignedBankRefNo",
    "relatedCompany1",
    "relatedCompany2",
    "relatedCompany3"

]);


IMMap.set("PART", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

IMMap.set("CORP", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

IMMap.set("CMP", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);


IMMap.set("IND", [
    "firstName",
    "middleName",
    "lastName"
]);


IMMap.set("SPROP", [
    "firstName",
    "middleName",
    "lastName"
]);

IMReqMap.set("common-fields", [
    "clientType",
    "businessEntityType",
    "businessNature",
    "insClientNo",
    "companyName",
    "citizenship",
    "address",
    "city",
    "zipCode",
    "country",
    "telNo",
    "tinNo",
    "email",
    "primaryVASPNo",
    "primaryBrokerTIN",
    "primaryBrokerCCN"
]);

IMReqMap.set("PART", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

IMReqMap.set("CORP", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

IMReqMap.set("CMP", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

IMReqMap.set("IND", [
    "firstName",
    "middleName",
    "lastName"
]);

IMReqMap.set("SPROP", [
    "firstName",
    "middleName",
    "lastName"
]);

/**
 * Importer (IM) end
 * */


/**
 * Surety (SU)
 * */
SUMap.set("common-fields", [
    "certOfAuth",
    "underWritingCap",
    "sssNo",
    "passportNo",
    "driverLicenseNo",
    "prcIdNo",
    "uniqueRefNo",
    "relatedCompany1",
    "relatedCompany2",
    "relatedCompany3"

]);

SUMap.set("PART", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

SUMap.set("CORP", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

SUMap.set("CMP", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

SUReqMap.set("common-fields", [
    "certOfAuth",
    "underWritingCap"
]);

SUReqMap.set("PART", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

SUReqMap.set("CORP", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

SUReqMap.set("CMP", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

/**
 * Surety (SU) end
 * */


/**
 * Warehouse Operator (WO)
 * */

WOMap.set("common-fields", [
    "clientType",
    "businessEntityType",
    "businessNature",
    "insClientNo",
    "companyName",
    "citizenship",
    "address",
    "city",
    "zipCode",
    "country",
    "telNo",
    "altTelNo",
    "fax",
    "mobileNo",
    "email",
    "website",
    "bondedWarehouseType",
    "tinNo",
    "sssNo",
    "passportNo",
    "driverLicenseNo",
    "prcIdNo",
    "primaryVASPNo",
    "secondaryVASPNo",
    "uniqueRefNo",
    "relatedCompany1",
    "relatedCompany2",
    "relatedCompany3",
    "primaryBrokerTIN",
    "primaryBrokerCCN",
    "secondaryBrokerTIN",
    "secondaryBrokerCCN"

]);

WOMap.set("PART", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

WOMap.set("CORP", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

WOMap.set("CMP", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

WOMap.set("IND", [
    "firstName",
    "middleName",
    "lastName"
]);


WOMap.set("SPROP", [
    "firstName",
    "middleName",
    "lastName"
]);

//******map reuqired fields here*******

WOReqMap.set("common-fields", [
    "clientType",
    "businessEntityType",
    "businessNature",
    "insClientNo",
    "companyName",
    "citizenship",
    "address",
    "city",
    "zipCode",
    "country",
    "telNo",
    "email",
    "bondedWarehouseType",
    "tinNo",
    "primaryVASPNo",
    "primaryBrokerTIN",
    "primaryBrokerCCN"
]);

WOReqMap.set("PART", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

WOReqMap.set("CORP", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

WOReqMap.set("CMP", [
    "SECRegNo",
    "authCapitalStockAmount",
    "paidUpCapitalAmount"
]);

WOReqMap.set("IND", [
    "firstName",
    "middleName",
    "lastName"
]);


WOReqMap.set("SPROP", [
    "firstName",
    "middleName",
    "lastName"
]);

/**
 * Warehouse Operator (WO) end
 * */


/**
 * Non-Regular Importer (YI) - previously labeled as 'Once A Year Importer'
 * */
YIMap.set("common-fields", [

]);

YIReqMap.set("common-fields", [

]);

/**
 * Non-Regular Importer (YI) end
 * */

function addFieldsToAll(map) {
    map.forEach((arr) => {
        (arr || []).forEach(fieldId => allFieldsList.add(fieldId));
    });
}

addFieldsToAll(ARMap);
addFieldsToAll(AWMap);
addFieldsToAll(BRMap);
addFieldsToAll(CYMap);
addFieldsToAll(EXMap);
addFieldsToAll(IMMap);
addFieldsToAll(SUMap);
addFieldsToAll(WOMap);
addFieldsToAll(YIMap);


/**
 * Maps created here are need to be exported in order for other JS files to use it
 *
 * Then, on other JS files that would use these maps add:
 * import {mainFieldMap, mainReqFieldMap} from "./fieldMappings.js";
 *
 * on ftl files declare fieldMappings.js and other js files as a module:
 *   <!-- load both files as modules -->
 *   <script type="module" src="fieldMappings.js"></script>
 *   <script type="module" src="other.js"></script>
 *
 * other scripts that are not declared as 'module' can be defined as usual:
 *   <script src="legacy.js" type="text/javascript"></script>
 *
 * */
export {mainFieldMap, mainReqFieldMap, allFieldsList};