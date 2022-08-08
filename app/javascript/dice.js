import DiceBox from "@3d-dice/dice-box";

let Box = new DiceBox("#dice-box",{
  assetPath: '/dice-box/',
})

Box.init().then(() => {});

Box.onRollComplete = function(dieResult) {
  console.log(dieResult);
}

export function rollDice(dice) {
  Box.add(dice);
}