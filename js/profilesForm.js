
window.onload = function () {
    limitPicSize();
    changeFormDependingOnBusinessEntity();
};

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


function changeFormDependingOnBusinessEntity(){
    const dropdown = document.getElementById("businessEntityType");
    dropdown.addEventListener("DOMContentLoaded", manageHiddenFieldsBasedOnSelectedBusinessEntity);
    dropdown.addEventListener("change", manageHiddenFieldsBasedOnSelectedBusinessEntity);

}

function manageHiddenFieldsBasedOnSelectedBusinessEntity(){
    const selectedValue = this.value;
    const fName = document.getElementById("firstName");
    const middleName = document.getElementById("middleName");
    const lName = document.getElementById("lastName");

    // Do something depending on chosen option
    if (!(selectedValue === "SPROP" || selectedValue === "IND")) {
        fName.style.display = "block";
        middleName.style.display = "block";
        lName.style.display = "block";
        fName.value = "";
        middleName.value = "";
        lName.value = "";
    }
}