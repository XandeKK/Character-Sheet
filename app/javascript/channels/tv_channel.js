import consumer from "channels/consumer"
import {rollDice} from "../dice"

class TvChannel {
  constructor() {
    this.addEvent();
  }

  addEvent() {
    document.addEventListener("turbo:submit-end", this.start.bind(this));
  }

  start() {
    this.channel = this.createChannel();
  }

  createChannel() {
    const tvChannel = consumer.subscriptions.create({channel: "TvChannel", unique_name: unique_name.value}, {
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
        let image = data["image"];

        rollDice({
          qty: quantity,
          dice: dice,
          bonus: bonus,
          color: color,
          theme: theme,
          name: name,
          image: image
        })
      }
    });
    return tvChannel;
  }
}

window.addEventListener("turbo:load", function() {
  if (document.getElementById("form") !== null) {
    const tvChannel = new TvChannel();
  }
})