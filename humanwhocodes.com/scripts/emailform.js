function submitEmailForm(form) {

    // only doing Ajax with fetch() for simplicity
    if (!window.fetch) {
        return true;
    }

    form.elements[0].disabled = true;
    form.elements[1].disabled = true;

    fetch("/.netlify/functions/subscribe", {
        method: "post",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({ email: form.elements["email"].value })
    }).then(response => {
        if (response.status !== 200) {
            alert("Invalid status code:" + response.status);
            form.elements[0].disabled = false;
            form.elements[1].disabled = false;
            return;
        }

        location.href = "/emails/success.html";
    }).catch(err => {
        alert("ERROR: " + err.message);
        form.elements[0].disabled = false;
        form.elements[1].disabled = false;
    });

    return false;
}
