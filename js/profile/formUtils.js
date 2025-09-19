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

/**
 * showElement(el, show)
 * - finds the enclosing <tr> (if any) and explicitly sets display so it overrides the
 *   CSS rule tr.managed-field { display: none; }.
 */
function showElement(el, show) {
    const row = el?.closest("tr") || el?.parentElement?.closest("tr");
    if (row) {
        // for table rows explicitly set table-row so the inline style overrides CSS
        row.style.display = show ? "table-row" : "none";
    }

    // element itself: inputs/selects — hide/show by inline style (let default display be used for show)
    el.style.display = show ? "" : "none";
    el.disabled = !show;
}


function setSaveBtnActionName(elementId, actionName){
    const element = document.getElementById(elementId);
    element.setAttribute("name", `action:${actionName}`);
}

export { toggleRequiredMarker, showElement, setSaveBtnActionName};
