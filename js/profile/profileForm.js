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
    // inside your IIFE (or top-level if you prefer)
// ensure mainFieldMap and mainReqFieldMap are imported at top of file

    function manageHidden(dropdown) {
        const businessType = (dropdown?.value || "").trim().toUpperCase();
        const clientTypeEl = document.getElementById("clientType");
        const clientType = clientTypeEl ? clientTypeEl.value.trim().toUpperCase() : null;

        if (!clientType) {
            console.warn("manageHidden: clientType not found");
            return;
        }

        const clientMap = mainFieldMap.get(clientType);
        const clientReqMap = mainReqFieldMap.get(clientType);

        if (!clientMap) {
            console.warn("manageHidden: no mapping found for clientType:", clientType);
            return;
        }

        // arrays from maps (short IDs as in your mappings)
        const commonFields = clientMap.get("common-fields") || [];
        const visibleUniqueFields = new Set(clientMap.get(businessType) || []);

        // Build set of all unique fields controlled by this clientType (all business-type specific fields)
        const controlledUniqueFields = new Set();
        for (const [bt, arr] of clientMap.entries()) {
            if (bt === "common-fields") continue;
            (arr || []).forEach(id => controlledUniqueFields.add(id));
        }

        // Required sets
        const commonReq = clientReqMap ? (clientReqMap.get("common-fields") || []) : [];
        const uniqueReqForThisBT = clientReqMap ? (clientReqMap.get(businessType) || []) : [];

        // Helper to find elements by shortId suffix (matches id or name)
        const selectorForShortId = (shortId) => `[id$="${shortId}"], [name$="${shortId}"]`;

        // 1) For each controlled unique field: hide if not visible, show if visible.
        controlledUniqueFields.forEach(shortId => {
            const els = document.querySelectorAll(selectorForShortId(shortId));
            els.forEach(el => {
                const row = el.closest("tr") || el.parentElement?.closest("tr");
                if (visibleUniqueFields.has(shortId)) {
                    if (row) row.style.display = "";
                } else {
                    if (row) row.style.display = "none";
                    // clear value for unique fields that are being hidden
                    if (el.tagName === "INPUT" || el.tagName === "SELECT" || el.tagName === "TEXTAREA") {
                        if (el.type === "checkbox" || el.type === "radio") {
                            el.checked = false;
                        } else {
                            el.value = "";
                        }
                    }
                }
                // remove required; will reapply below only for visible ones
                toggleRequiredMarker(el, false);
            });
        });

        // 2) Ensure common fields are visible and not cleared (do not touch values)
        commonFields.forEach(shortId => {
            const els = document.querySelectorAll(selectorForShortId(shortId));
            els.forEach(el => {
                const row = el.closest("tr") || el.parentElement?.closest("tr");
                if (row) row.style.display = "";
                // remove any previous required flag; we'll reapply combined required next
                toggleRequiredMarker(el, false);
            });
        });

        // 3) Make visible unique fields explicitly visible (in case they were inside hidden container)
        visibleUniqueFields.forEach(shortId => {
            const els = document.querySelectorAll(selectorForShortId(shortId));
            els.forEach(el => {
                const row = el.closest("tr") || el.parentElement?.closest("tr");
                if (row) row.style.display = "";
            });
        });

        // 4) Reapply `required` to the fields that must be required now:
        //    - common required fields
        //    - unique required fields for the selected businessType (but only for visible unique fields)
        const mustBeRequired = new Set();
        commonReq.forEach(id => mustBeRequired.add(id));
        uniqueReqForThisBT.forEach(id => mustBeRequired.add(id));

        mustBeRequired.forEach(shortId => {
            // apply only if it's visible now (either common or visible unique)
            if (!commonFields.includes(shortId) && !visibleUniqueFields.has(shortId)) return;
            document.querySelectorAll(selectorForShortId(shortId)).forEach(el => {
                toggleRequiredMarker(el, true);
            });
        });
    }

    function toggleRequiredMarker(el, isRequired) {
        const label = document.querySelector(`label[for="${el.id}"]`);
        if (!label) return;

        let reqSpan = label.querySelector("span.required");

        if (isRequired) {
            el.setAttribute("required", "true");
            if (!reqSpan) {
                reqSpan = document.createElement("span");
                reqSpan.className = "required";
                reqSpan.textContent = "*";
                // Insert before colon if label text has one
                if (label.textContent.includes(":")) {
                    label.insertBefore(reqSpan, label.lastChild);
                } else {
                    label.appendChild(reqSpan);
                }
            }
        } else {
            el.removeAttribute("required");
            if (reqSpan) reqSpan.remove();
        }
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



