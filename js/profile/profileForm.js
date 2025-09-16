import {mainFieldMap, mainReqFieldMap} from "./fieldMappings.js";


window.addEventListener("load", function () {
    limitPicSize();
});

function limitPicSize(){ 1
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
    var select = document.getElementById("natureOfBusinessSelect");
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

        // Collect displayable fields
        const FIELD_IDS = [];
        const REQ_FIELD_IDS = [];

        mainFieldMap.get(clientType).get(businessType)?.forEach(id => FIELD_IDS.push(id));
        mainFieldMap.get(clientType).get("common-fields")?.forEach(id => FIELD_IDS.push(id));

        mainReqFieldMap.get(clientType).get(businessType)?.forEach(id => REQ_FIELD_IDS.push(id));
        mainReqFieldMap.get(clientType).get("common-fields")?.forEach(id => REQ_FIELD_IDS.push(id));

        // Reset everything (hide + clear)
        document.querySelectorAll("tr").forEach(row => {
            row.style.display = "none";
            const inputs = row.querySelectorAll("input, select, textarea");
            inputs.forEach(el => {
                el.value = "";              // clear values
                el.removeAttribute("required"); // reset required
            });
        });

        // Show allowed fields
        const displayFields = getFieldRows(FIELD_IDS);
        displayFields.forEach(row => { row.style.display = ""; });

        // Apply "required"
        REQ_FIELD_IDS.forEach(id => {
            const el = document.getElementById(id);
            if (el) el.setAttribute("required", "true");
        });
    }

    function init() {
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



