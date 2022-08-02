class Character {
	getAbility(name) {
		return main_json.character.ability[name];
	}

	getAbilityModifier(name) {
		let point = this.getAbility(name);
		let modifier = Math.floor(point/2) - 5;
		return modifier;
	}

	getPerception() {
		let item = main_json.character.perception.item;
		let proficiency = main_json.character.perception.proficiency;
		let wisdom = this.getAbilityModifier("wisdom");
		return wisdom;
	}

	getAC() {
		let item = main_json.character.armorClass.item;
		let proficiency = main_json.character.armorClass.proficiency;
		let capable = main_json.character.armorClass.capable;
		let dexterity = this.getAbilityModifier("dexterity");

		if (capable <= dexterity) {dexterity = capable}

		let ac = item + proficiency + dexterity;
		return ac;
	}
}