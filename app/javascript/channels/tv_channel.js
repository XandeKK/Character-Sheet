import consumer from "channels/consumer"
import {rollDice} from "../dice"

document.addEventListener("turbo:submit-end", connect)
let tvChannel;

function connect(event) {  
  tvChannel = consumer.subscriptions.create({channel: "TvChannel", unique_name: unique_name.value}, {
    connected() {
    },

    disconnected() {
    },

    received(data) {
      let quantity = data["qty"];
      let dice = data["dice"];
      let bonus = data["bonus"];
      let color = data["color"];
      let theme = data["theme"];
      let name = data["name"];

      rollDice({
        qty: quantity,
        dice: dice,
        bonus: bonus,
        color: color,
        theme: theme,
        name: name
      })
    }
  });
}
