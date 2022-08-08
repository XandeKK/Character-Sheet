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
      let dice = data["dice"]
      rollDice(dice)
    }
  });
}
