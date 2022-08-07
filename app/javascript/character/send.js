function sendHP() {
  let xhttp = new XMLHttpRequest();
  let csrf = document.querySelector("[name='csrf-token']").content;

  let characterList = localStorage.getItem("characterList");
  if (characterList === '{}') {return} 
  let list = {};
  list["characterList"] = characterList
  list = JSON.stringify(list)

  xhttp.open("PUT", "http://10.0.0.22:3000/character/update_all_life", true);
  xhttp.setRequestHeader('X-CSRF-Token', csrf);
  xhttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
  xhttp.send(list);

  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      localStorage.setItem("characterList", '{}');
    }
  };
}

document.addEventListener("DOMContentLoaded", main);

function main() {
  setInterval(sendHP, 60000);
}