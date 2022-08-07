var npc = document.getElementById('Npc');
var enemy = document.getElementById('Enemy');

var observer = new MutationObserver(function(mutations) {
  mutations.forEach(function(mutation) {
    if (mutation.type === 'childList') {
      damageBtnArray = document.querySelectorAll(".damageBtn")
      healBtnArray = document.querySelectorAll(".healBtn")
      temporaryBtnArray = document.querySelectorAll(".temporaryBtn")

      for (var i = 0; i < damageBtnArray.length; i++) {
        damageBtnArray[i].addEventListener("click", damageHp)
      }

      for (var i = 0; i < healBtnArray.length; i++) {
        healBtnArray[i].addEventListener("click", healHp)
      }

      for (var i = 0; i < temporaryBtnArray.length; i++) {
        temporaryBtnArray[i].addEventListener("click", addTemporaryHp)
      }
    }
  });
});

observer.observe(npc, {
  childList: true
});

observer.observe(enemy, {
  childList: true
});