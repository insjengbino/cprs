/**
 * The following are the map of fields displayed on form per ClientType and per BusinessType.
 * The values inside each map are the ids contained in ftl file (or what will be rendered in html in runtime).
 **/
let mainFieldMap = new Map;
let mainReqFieldMap = new Map;

let ARMap = new Map;
let ARReqMap = new Map;

mainFieldMap.set("AR", ARMap);
mainReqFieldMap.set("AR",ARReqMap);

/**
 * Arrastre Operator Map
 */

//COMPANY
ARMap.set("COMP", [
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


//COMPANY
ARReqMap.set("COMP", [
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
 * */


/**
 * Maps created here are need to be exported in order for other JS files to use it
 *
 * Then, on other JS files that would use these maps add:
 * import {mainFieldMap, mainReqFieldMap, ARMap, ARReqMap} from "./fieldMappings.js";
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
export {mainFieldMap, mainReqFieldMap};