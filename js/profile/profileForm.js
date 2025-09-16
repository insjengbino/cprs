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
    function manageHidden(dropdown) {
        const businessType = dropdown.value.trim().toUpperCase();
        const clientType = document.getElementById("clientType").value.trim().toUpperCase();

        // Separate lists
        const UNIQUE_FIELD_IDS = [];
        const COMMON_FIELD_IDS = [];
        const UNIQUE_REQ_FIELD_IDS = [];
        const COMMON_REQ_FIELD_IDS = [];

        // Unique fields
        mainFieldMap.get(clientType).get(businessType)?.forEach(id => UNIQUE_FIELD_IDS.push(id));
        mainReqFieldMap.get(clientType).get(businessType)?.forEach(id => UNIQUE_REQ_FIELD_IDS.push(id));

        // Common fields
        mainFieldMap.get(clientType).get("common-fields")?.forEach(id => COMMON_FIELD_IDS.push(id));
        mainReqFieldMap.get(clientType).get("common-fields")?.forEach(id => COMMON_REQ_FIELD_IDS.push(id));

        console.log("unique display fields: " + UNIQUE_FIELD_IDS);
        console.log("common display fields: " + COMMON_FIELD_IDS);
        console.log("unique required fields: " + UNIQUE_REQ_FIELD_IDS);
        console.log("common required fields: " + COMMON_REQ_FIELD_IDS);

        console.log("client type: " + clientType);
        console.log("business type: " + businessType);


        // Step 1: Reset only unique fields (hide + clear)
        document.querySelectorAll("tr").forEach(row => {
            const inputs = row.querySelectorAll("input, select, textarea");

            // check if this row contains any unique field
            const rowHasUnique = Array.from(inputs).some(el =>
                UNIQUE_FIELD_IDS.some(uniqueId =>
                    el.id.endsWith(uniqueId) || el.name.endsWith(uniqueId)
                )
            );

            if (rowHasUnique) {
                // clear only unique fields when hidden
                inputs.forEach(el => {
                    if (
                        UNIQUE_FIELD_IDS.some(uniqueId =>
                            el.id.endsWith(uniqueId) || el.name.endsWith(uniqueId)
                        )
                    ) {
                        el.value = "";
                    }
                });
            }
        });

        // Step 2: Show relevant unique fields
        UNIQUE_FIELD_IDS.forEach(id => {
            const el = document.getElementById(id);
            if (el) {
                const row = el.closest("tr") || el.parentElement?.closest("tr");
                if (row) row.style.display = "";
            }
        });

        // Step 3: Always keep common fields visible
        COMMON_FIELD_IDS.forEach(id => {
            const el = document.getElementById(id);
            if (el) {
                const row = el.closest("tr") || el.parentElement?.closest("tr");
                if (row) row.style.display = "";
            }
        });

        // Step 4: Apply required rules
        UNIQUE_REQ_FIELD_IDS.concat(COMMON_REQ_FIELD_IDS).forEach(id => {
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



