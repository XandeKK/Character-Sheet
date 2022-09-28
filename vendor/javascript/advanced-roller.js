import DiceParser from '@3d-dice/dice-parser-interface'

const noop = () => {}

class AdvancedRoller{
  constructor(options){
    // create Notation Parser - pass on options
    this.DRP = new DiceParser({
      targetRollsCritSuccess: options?.targetRollsCritSuccess || options?.targetRollsCritSuccess || false,
      targetRollsCritFailure: options?.targetRollsCritFailure || options?.targetRollsCrit || false,
      targetRollsCrit: options?.targetRollsCrit || false,
    })

    // callback events
    this.onSubmit = options?.onSubmit || noop
    this.onClear = options?.onClear || noop
    this.onReroll = options?.onReroll || noop
    this.onResults = options?.onResults || noop
  }

  submit(data, theme) {
    this.clear()
    this.onSubmit(this.DRP.parseNotation(data), theme)
  }

  clear(){
    this.DRP.clear()
  }
  handleResults(results, id){
    // convert string names back to intigers needed by DRP
    const diceNotation = /[dD]\d+/i
    results.forEach(result => {
      if(typeof result.sides === "string" && result.sides.match(diceNotation)){
        result.sides = parseInt(result.sides.substring(1))
      }
      result.rolls.forEach(roll => {
        if(typeof roll.sides === "string" && roll.sides.match(diceNotation)){
          roll.sides = parseInt(roll.sides.substring(1))
        }
      })
    })

    // 
    // const rerolls = this.DRP.handleRerolls(results)
    // if(rerolls.length) {
    //   this.onReroll(rerolls)
    //   return rerolls
    // }

    const finalResults = this.DRP.parsedNotation ? this.DRP.parseFinalResults(results, id) : results

    finalResults["playerPosition"] = id

    // dispatch an event with the results object for other UI elements to listen for
    const event = new CustomEvent('resultsAvailable', {detail: finalResults})
    document.dispatchEvent(event)

    this.onResults(finalResults)
    
    return finalResults
  }
}

export default AdvancedRoller