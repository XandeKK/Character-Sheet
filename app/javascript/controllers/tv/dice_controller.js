import { Controller } from "@hotwired/stimulus"
import DiceBox from "@3d-dice/dice-box";

export default class extends Controller {
  static targets = []

  connect() {
    this.box = new DiceBox("#dice-box", {
      id: "dice-canvas",
      assetPath: '/dice-box/',
      scale: 6
    })

    document.getElementById("dice-canvas").className = "fixed pointer-events-none w-full h-full"

    this.box.init();

    this.box.onRollComplete = this.rollComplete.bind(this);
  }

  rollDice(data) {
    this.box.add(data.dice, {
      themeColor: data.color,
      theme: data.theme,
    });
  }

  rollComplete(dieResult) {
    console.log(dieResult)
  }

  getDices({ detail: { data }}) {
    this.rollDice({ 
      dice: data.dice,
      color: data.color,
      theme: data.theme
    })
  }
}

