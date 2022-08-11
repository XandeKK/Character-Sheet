import consumer from "channels/consumer"


window.addEventListener("DOMContentLoaded", function() {
  const serverName = document.getElementById("serverName");
  const btn = document.getElementById("diceBtn");
  btn.addEventListener("click", rollDice);

  const gmChannel = consumer.subscriptions.create({channel: "GmChannel", unique_name: serverName.textContent }, {
    connected() {
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      // Called when there's incoming data on the websocket for this channel
    }
  });


  function rollDice(event) {
    let quantity = document.getElementById("quantity").value || 1;
    let dice = document.getElementById("dice").value || "d4";
    let bonus = document.getElementById("bonus").value || 0; 
    let character = document.getElementById("characterId").value;
    let name = document.getElementById("name").value;
    let color = document.getElementById("color").value || "#fff";
    let theme = document.getElementById("theme").value || "default";
    let image = document.getElementById("characterImage").value;
    
    gmChannel.send({ 
      name: name,
      qty: quantity,
      dice: dice,
      bonus: bonus,
      character: character,
      color: color,
      theme: theme,
      image: image
    });
  }
})