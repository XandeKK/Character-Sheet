function saveOnExit(event) {
  var confirmationMessage = "\o/";

  if (localStorage.getItem("updated") === "true") {
    // show a message that data was saved
    sendHP();
    return 'Are you sure you want to leave?';
  }
}

window.onbeforeunload = saveOnExit;