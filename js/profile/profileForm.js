import {mainFieldMap, mainReqFieldMap, allFieldsList} from "./fieldMappings.js";


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

        // Required sets
        const commonReq = clientReqMap ? (clientReqMap.get("common-fields") || []) : [];
        const uniqueReqForThisBT = clientReqMap ? (clientReqMap.get(businessType) || []) : [];

        // Helper to find elements by shortId suffix (matches id or name)
        const selectorForShortId = (shortId) => `[id$="${shortId}"], [name$="${shortId}"]`;

        // --- NEW: handle all fields (from allFieldsList) ---
        allFieldsList.forEach(shortId => {
            const isVisible = commonFields.includes(shortId) || visibleUniqueFields.has(shortId);
            const els = document.querySelectorAll(selectorForShortId(shortId));

            els.forEach(el => {
                const row = el.closest("tr") || el.parentElement?.closest("tr");
                if (isVisible) {
                    if (row) row.style.display = "";
                    el.disabled = false;
                    el.style.display = "";
                } else {
                    if (row) row.style.display = "none";
                    el.disabled = true;   // disable so it's not in payload
                }
                // reset required always
                toggleRequiredMarker(el, false);
            });
        });

        // --- Reapply required markers ---
        const mustBeRequired = new Set([...commonReq, ...uniqueReqForThisBT]);

        mustBeRequired.forEach(shortId => {
            // only if it’s currently visible
            if (!commonFields.includes(shortId) && !visibleUniqueFields.has(shortId)) return;
            document.querySelectorAll(selectorForShortId(shortId)).forEach(el => {
                toggleRequiredMarker(el, true);
            });
        });
    }

    // expose globally if needed
    window.manageHidden = manageHidden;

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

                const colonIndex = label.textContent.lastIndexOf(":");
                if (colonIndex !== -1) {
                    const textBeforeColon = label.textContent.slice(0, colonIndex).trimEnd();
                    const textAfterColon = label.textContent.slice(colonIndex);
                    label.textContent = textBeforeColon;
                    label.appendChild(reqSpan);
                    label.appendChild(document.createTextNode(textAfterColon));
                } else {
                    label.appendChild(reqSpan);
                }
            }
        } else {
            el.removeAttribute("required");
            if (reqSpan && !reqSpan.dataset.fromStruts) {
                reqSpan.remove();
            }
        }
    }

    document.addEventListener("DOMContentLoaded", () => {
        document.querySelectorAll("label span.required").forEach(span => {
            span.dataset.fromStruts = "true";
        });
    });

    function init() {
        console.log("init() running...");
        const dropdown = document.getElementById("businessEntityType");
        if (!dropdown) {
            console.warn("Dropdown #businessEntityType not found");
            return;
        }

        manageHidden(dropdown);
        dropdown.addEventListener("change", () => manageHidden(dropdown));
    }

    document.addEventListener("DOMContentLoaded", init);
})();




