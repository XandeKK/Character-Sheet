import DiceBox from "@3d-dice/dice-box";

let Box = new DiceBox("#dice-box",{
  assetPath: '/dice-box/',
})

Box.init().then(() => {});

Box.onRollComplete = function(dieResult) {
  console.log(dieResult);
}

export function rollDice(property) {
  let dice = concatenate(property["qty"], property["dice"], property["bonus"])
  Box.add(dice, {
    themeColor: property["color"],
    theme: property["theme"]
   });
}

function concatenate(qty, dice, bonus) {
  if (bonus > 0) {
    bonus = "+" + bonus;
  } else if (bonus == 0) {
    bonus = "";
  }
  return qty + dice + bonus;
}