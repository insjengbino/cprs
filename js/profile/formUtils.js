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

function showElement(el, show) {
    const row = el.closest("tr") || el.parentElement?.closest("tr");
    if (row) row.style.display = show ? "" : "none";
    el.disabled = !show;
    el.style.display = show ? "" :"none";
}

export {toggleRequiredMarker, showElement};

