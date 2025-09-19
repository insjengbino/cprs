import {mainFieldMap, mainReqFieldMap, allFieldsList} from "./fieldMappings.js";
import {toggleRequiredMarker, showElement, setSaveBtnActionName} from "./formUtils.js";
import {saveActionNameMap} from "./actionNameMappings.js";

window.addEventListener("load", function () {
    limitPicSize();
});

function limitPicSize(){
    var pictureImage = document.getElementsByName('profilePictureFile')[0];
    var signatureImage = document.getElementsByName('profileSignatureFile')[0];
    if (pictureImage) {
        pictureImage.addEventListener('change', function (event) {
            validateImageEvent(event)
        });
    }
    if (signatureImage) {
        signatureImage.addEventListener('change', function (event) {
            validateImageEvent(event)
        });
    }
}

function validateImageEvent(event) {
    var file = event.target.files[0];
    if (file && file.size > 5120) { // 5KB = 5120 bytes
        alert("Please be Informed that the uploaded attachment has exceeded the allowable file size limit of 5kb");
        event.target.value = ''; // Clear the file input
    }
}

document.addEventListener("DOMContentLoaded", function() {
    var select = document.getElementById("businessNature");
    if (select) {
        Array.from(select.options).forEach(function(opt, i) {
            opt.title = natureOfBusinessFullNames[i];
        });
    }
});

document.addEventListener('input', function (e) {
    const el = e.target;

    if (el.tagName === 'INPUT') {
        const skipNames = ['profile.email','profile.website'];
        if (skipNames.includes(el.name)) return;
        if (!el.type || el.type.toLowerCase() === "text") {
            const start = el.selectionStart;
            const end = el.selectionEnd;
            el.value = el.value.toUpperCase();
            el.setSelectionRange(start, end);
        }
    }

    else if (el.tagName === 'TEXTAREA') {
        const start = el.selectionStart;
        const end = el.selectionEnd;
        el.value = el.value.toUpperCase();
        el.setSelectionRange(start, end);
    }
});


(function () {
    function manageHiddenAfterBusinessTypeChange(dropdown) {
        const businessType = (dropdown?.value || "").trim().toUpperCase();
        const clientTypeEl = document.getElementById("clientType");
        const clientType = clientTypeEl ? clientTypeEl.value.trim().toUpperCase() : null;

        if (!clientType) {
            console.warn("manageHiddenAfterBusinessTypeChange: clientType not found");
            return;
        }

        const clientMap = mainFieldMap.get(clientType);
        const clientReqMap = mainReqFieldMap.get(clientType);

        if (!clientMap) {
            console.warn("manageHiddenAfterBusinessTypeChange: no mapping found for clientType:", clientType);
            return;
        }

        // arrays from maps (short IDs as in your mappings)
        const commonFields = clientMap.get("common-fields") || [];
        const visibleUniqueFields = new Set(clientMap.get(businessType) || []);

        // Required sets
        const commonReq = clientReqMap ? (clientReqMap.get("common-fields") || []) : [];
        const uniqueReqForThisBT = clientReqMap ? (clientReqMap.get(businessType) || []) : [];

        function isVisible(shortId){
            return commonFields.includes(shortId) || visibleUniqueFields.has(shortId);
        }

        // --- NEW: handle all fields (from allFieldsList) ---
        allFieldsList.forEach(shortId => {
            const els = selectorForShortId(shortId);

            els.forEach(el => {
                const row = el.closest("tr") || el.parentElement?.closest("tr");
                if (isVisible(shortId)) {
                    if (row) showElement(row, true);
                    el.disabled = false;
                    el.style.display = "";
                } else {
                    if (row) showElement(row, false)
                    el.disabled = true;   // disable so it's not in payload
                }
                // reset required always
                toggleRequiredMarker(el, false);
            });
        });

        // --- Reapply required markers ---
        const mustBeRequired = new Set([...commonReq, ...uniqueReqForThisBT]);

        mustBeRequired.forEach(shortId => {
            const els = selectorForShortId(shortId);
            // only if it’s currently visible
            if (!isVisible(shortId)) return;
            els.forEach(el => {
                toggleRequiredMarker(el, true);
            });
        });

        //set save button action depending on clientType and businessType
        const saveActionNameHandler = saveActionNameMap[clientType];

        if (saveActionNameHandler) {
            setSaveBtnActionName("saveBtn", saveActionNameHandler(businessType));
        } else {
            console.warn(`No save action defined for client type: ${clientType} and businessType: ${businessType}`);
            setSaveBtnActionName("saveBtn", ""); // optional fallback
        }

    }

    // expose globally if needed
    window.manageHiddenAfterBusinessTypeChange = manageHiddenAfterBusinessTypeChange;



    document.addEventListener("DOMContentLoaded", () => {
        document.querySelectorAll("label span.required").forEach(span => {
            span.dataset.fromStruts = "true";
        });
    });

    function manageHiddenAfterBusinessNatureChange(dropdown){
        const businessNatureCode = (dropdown?.value || "").trim().toUpperCase();

        const clientTypeEl = document.getElementById("clientType");
        const clientType = clientTypeEl ? clientTypeEl.value.trim().toUpperCase() : null;

        const prcIdNoEl = document.getElementById("prcIdNo");
        const importerTin = document.getElementById("importerTin");
        const exporterTin = document.getElementById("exporterTin");

        const manageableElements = [prcIdNoEl, importerTin, exporterTin].filter(Boolean);

        const prc = "prcIdNo";
        const nonBr = "NONBROKER";

        if (clientType === "BR") {
            if (businessNatureCode === "0000") {
                manageableElements.forEach(el => {
                    showElement(el, true);
                    toggleRequiredMarker(el, true);
                    if (el.id === "prcIdNo") {
                        if (!el.dataset.originalValue) {
                            el.dataset.originalValue = el.value || "";
                        }
                        el.readOnly = true;
                        el.value = nonBr;
                    }
                });
            } else {
                manageableElements.forEach(el => {
                    if (el.id === prc) { //prcIdNo is required for BR regardless of businessNature
                        showElement(el, true);
                        el.readOnly = false;
                        toggleRequiredMarker(el, true);
                        if (el.value === nonBr)  el.value = el.dataset.savedValue || el.dataset.originalValue || "";

                    } else {
                        showElement(el, false);
                        toggleRequiredMarker(el, false);
                    }
                });
            }
        }else{
            showElement(importerTin, false);
            toggleRequiredMarker(importerTin, false);
            showElement(exporterTin, false);
            toggleRequiredMarker(exporterTin, false);
        }

        if (businessNatureCode === "GO004") {
            // TODO: handle GO004
        }

    }

    document.addEventListener("DOMContentLoaded", () => {
        const prcIdNoEl = document.getElementById("prcIdNo");
        if (prcIdNoEl) {
            prcIdNoEl.addEventListener("input", e => {
                if (e.target.value !== "NONBROKER") {
                    e.target.dataset.savedValue = e.target.value;
                }
            });
        }
    });

    // expose globally if needed
    window.manageHiddenAfterBusinessNatureChange = manageHiddenAfterBusinessNatureChange ;

    function init() {
        console.log("init() running...");
        const businessTypeDropdown = document.getElementById("businessEntityType");
        const businessNatureDropdown = document.getElementById("businessNature");
        if (!businessTypeDropdown) {
            console.warn("Dropdown #businessEntityType not found");
            return;
        }

        if (!businessNatureDropdown) {
            console.warn("Dropdown #businessNature not found");
            return;
        }

        manageHiddenAfterBusinessTypeChange(businessTypeDropdown);
        manageHiddenAfterBusinessNatureChange(businessNatureDropdown);
        businessTypeDropdown.addEventListener("change", () => manageHiddenAfterBusinessTypeChange(businessTypeDropdown));
        businessNatureDropdown.addEventListener("change", () => manageHiddenAfterBusinessNatureChange(businessNatureDropdown));

        // Show form only after applying visibility logic
        document.getElementById("profileFormFields").style.visibility = "visible";
    }

    document.addEventListener("DOMContentLoaded", init);

    //Helper to find elements by shortId suffix (matches id or name)
    //currently this functions is able to return a list of nodes
    //but, it is expected to return a list with 1 element only
    //there will be a warning if list size > 1 or < 1
    //id$= and name$= ($ === ends with) hence ids like clientType and businessType will be returned if the shortId is `type`
    function selectorForShortId(shortId) {
        const selector = `[id$="${shortId}"], [name$="${shortId}"]`;
        const matches = document.querySelectorAll(selector);

        if (matches.length > 1) {
            console.warn(`⚠️ shortId "${shortId}" matched ${matches.length} elements.`, matches);
        } else if (matches.length === 0) {
            console.warn(`⚠️ shortId "${shortId}" did not match any element.`);
        }

        return matches; // return NodeList directly
    }

})();




