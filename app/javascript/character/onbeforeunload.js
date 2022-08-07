function saveOnExit(event) {
  if (localStorage.getItem("updated") === "true") {
    sendHP();
    return 'Are you sure you want to leave?';
  }
}

function clickSave(event) {
  sendHP();
}

window.onbeforeunload = saveOnExit;
saveBtn.addEventListener("click", clickSave)