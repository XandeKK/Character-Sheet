function sendHP() {
  let xhttp = new XMLHttpRequest();
  let csrf = document.querySelector("[name='csrf-token']").content;
  let origin = window.location.origin;
  let url = origin + "/character/update_all_life"

  let characters = localStorage.getItem("characters");
  if (characters === '{}') {return} 
  let list = {};
  list["characters"] = characters
  list = JSON.stringify(list)

  xhttp.open("PUT", url, true);
  xhttp.setRequestHeader('X-CSRF-Token', csrf);
  xhttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
  xhttp.send(list);

  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      localStorage.setItem("characters", '{}');
      localStorage.setItem("updated", false);;
      saveBtn.disabled = true;
    }
  };
}

document.addEventListener("DOMContentLoaded", main);

function main() {
  setInterval(sendHP, 60000);
}