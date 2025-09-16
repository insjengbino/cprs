import {mainFieldMap, mainReqFieldMap} from "./fieldMappings.js";


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

const natureOfBusinessFullNames = [
    <#list naturesOfBusiness as item>
"${item.name?js_string}"<#if item_has_next>,</#if>
</#list>
];

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
        if (el.type.toLowerCase() === 'text' || el.type === '') {
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
    function getFieldRows(fieldList) {
        return fieldList
            .map(id => {
                const el = document.getElementById(id);
                return el ? el.closest("tr") || el.parentElement?.closest("tr") : null;
            })
            .filter(Boolean);
    }

    function manageHidden(dropdown) {
        const businessType = dropdown.value.trim().toUpperCase();
        const clientType = document.getElementById("clientType").value.trim().toUpperCase();

        // Collect displayable + required fields
        const FIELD_IDS = [];
        const REQ_FIELD_IDS = [];

        mainFieldMap.get(clientType)?.get(businessType).forEach(id => FIELD_IDS.push(id));
        mainFieldMap.get(clientType)?.get("common-fields").forEach(id => FIELD_IDS.push(id));

        mainReqFieldMap.get(clientType)?.get(businessType).forEach(id => REQ_FIELD_IDS.push(id));
        mainReqFieldMap.get(clientType)?.get("common-fields").forEach(id => REQ_FIELD_IDS.push(id));

        console.log("display fields: " + FIELD_IDS);
        console.log("required fields: " + REQ_FIELD_IDS);
        console.log("client type: " + clientType);
        console.log("business type: " + businessType);


        // Reset only the fields mentioned in the mapping
        const allControlledFields = [...new Set([...FIELD_IDS, ...REQ_FIELD_IDS])];
        allControlledFields.forEach(id => {
            const el = document.getElementById(id);
            if (el) {
                el.value = "";                               // clear values
                el.removeAttribute("required");  // reset required
                const row = el.closest("tr") || el.parentElement?.closest("tr");
                if (row) row.style.display = "none";
            }
        });

        // Show allowed fields
        FIELD_IDS.forEach(id => {
            const el = document.getElementById(id);
            if (el) {
                const row = el.closest("tr") || el.parentElement?.closest("tr");
                if (row) row.style.display = "";
            }
        });

        // Apply "required"
        REQ_FIELD_IDS.forEach(id => {
            const el = document.getElementById(id);
            if (el) el.setAttribute("required", "true");
        });
    }


    function init() {
        console.log("init() running...")
        const dropdown = document.getElementById("businessEntityType");
        if (!dropdown) {
            console.warn("Dropdown #businessEntityType not found");
            return;
        }

        // Initial state (handle default value)
        manageHidden(dropdown);

        // On change
        dropdown.addEventListener("change", () => manageHidden(dropdown));
    }

    document.addEventListener("DOMContentLoaded", init);
})();



