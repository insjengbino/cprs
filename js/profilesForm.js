
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

var natureOfBusinessFullNames = [
    <#list naturesOfBusiness as item>
"${item.name?js_string}"<#if item_has_next>,</#if>
</#list>
];

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
    const FIELD_IDS = ["firstName", "middleName", "lastName"];

    function getFieldRows() {
        // Hide the whole row (label + input), not just the input
        return FIELD_IDS
            .map(id => {
                const el = document.getElementById(id);
                return el ? el.closest("tr") || el.parentElement?.closest("tr") : null;
            })
            .filter(Boolean);
    }

    function manageHidden(dropdown) {
        const code = (dropdown.value || "").trim().toUpperCase();
        const showPersonal = !(code === "SPROP" || code === "IND");

        // Toggle entire rows
        const rows = getFieldRows();
        rows.forEach(row => { row.style.display = showPersonal ? "" : "none"; });

        // Optional: clear values when showing
        if (showPersonal) {
            FIELD_IDS.forEach(id => {
                const el = document.getElementById(id);
                if (el) el.value = "";
            });
        }
    }

    function init() {
        const dropdown = document.getElementById("businessEntityType");
        if (!dropdown) {
            console.warn("Dropdown #businessEntityType not found");
            return;
        }

        console.log("Dropdown found:", dropdown); // 👈 Debug
        // initial state (handles pre-filled/default value)
        manageHidden(dropdown);

        // react to user changes
        dropdown.addEventListener("change", () => manageHidden(dropdown));
    }

    // Use addEventListener to avoid being overwritten by other libs
    document.addEventListener("DOMContentLoaded", init);
})();