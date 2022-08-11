import consumer from "channels/consumer"

window.addEventListener("DOMContentLoaded", function() {
  let gmChannel;
  const serverName = document.getElementById("serverName");
  const serverBtn = document.getElementById("server");
  const btn = document.getElementById("diceBtn");

  serverBtn.addEventListener("click", server);

  function server() { // Initialize or close server
    if (serverBtn.getAttribute("open") === "true") {
      gmChannel.unsubscribe();
      gmChannel = null;

      serverBtn.textContent = "Start server";
      serverBtn.setAttribute("open", "false");

      btn.removeEventListener("click", rollDice);
      return;
    }
    btn.addEventListener("click", rollDice);

    gmChannel = consumer.subscriptions.create({channel: "GmChannel", unique_name: serverName.textContent }, {
      connected() {
        serverBtn.textContent = "Close server";
        serverBtn.setAttribute("open", "true");
        // Called when the subscription is ready for use on the server
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        // Called when there's incoming data on the websocket for this channel
      }
    });
  }

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
