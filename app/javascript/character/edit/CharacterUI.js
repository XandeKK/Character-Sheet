class CharacterUI {
	createSelectProficiency(name, id, parent) {
		let options = [
			{name: I18n.proficiency.untrained, value: 0},
			{name: I18n.proficiency.trained, value: 2},
			{name: I18n.proficiency.expert, value: 4},
			{name: I18n.proficiency.master, value: 6},
			{name: I18n.proficiency.legendary, value: 8}
		];
		base.createSelect(name, id, parent, options)
	}

	createSelectAbility(name, id, parent) {
		let options = [
			{name: I18n.statistics.ability.strength, value: "strength"},
			{name: I18n.statistics.ability.dexterity, value: "dexterity"},
			{name: I18n.statistics.ability.constitution, value: "constitution"},
			{name: I18n.statistics.ability.intelligence, value: "intelligence"},
			{name: I18n.statistics.ability.wisdom, value: "wisdom"},
			{name: I18n.statistics.ability.charisma, value: "charisma"}
		];
		base.createSelect(name, id, parent, options)
	}

	createSelectDamageType(name, id, parent) {
		let options = [
			{name: I18n.offense.piercing, value: "piercing"},
			{name: I18n.offense.slashing, value: "slashing"},
			{name: I18n.offense.bludgeoning, value: "bludgeoning"}
		];
		base.createSelect(name, id, parent, options)
	}

	createWeapon(isNew, type, parent) {
		if (isNew) {
			let size = main_json['character'][type].length;
			main_json['character'][type][size] = {}
		}

		base.createInput(I18n.offense.weapon, "weapon", parent, "text");

		if (type == "meleeStrikes") {
			base.createInput(I18n.offense["weapon strength"], "weaponStrength", parent, "number");
		} else {
			base.createInput(I18n.offense["weapon dexterity"], "weaponDexterity", parent, "number");
		}

		this.createSelectProficiency(I18n.proficiency.title, "proficiency", parent);
		base.createInput(I18n.item, "item", parent, "number");

		base.createInput(I18n.dice, "dice", parent, "text");
		this.createSelectDamageType(I18n.offense.type, "types", parent);

		if (type == "meleeStrikes") {
			base.createInput(I18n.offense["damage strength"], "damageStrength", parent, "text");
		} else {
			base.createInput(I18n.offense.special, "special", parent, "text");
			base.createInput(I18n.offense.range, "range", parent, "number");
		}

		base.createInput(I18n.offense["weapon specialization"], "weaponSpecialization", parent, "text");
		base.createInput(I18n.traits, "traits", parent, "text");
		base.createInput(I18n.other, "other", parent, "text");
		base.createTextArea(I18n.notes, "notes", parent);

		base.addDeleteButton(parent);
	}

	createLanguages(isNew, parent) {
		if (isNew) {
			let size = main_json['character']["languages"].length;
			main_json['character']["languages"][size] = {}
		}

		base.createInput(I18n.name, "name", parent, "text");
		base.createTextArea(I18n.notes, "notes", parent);

		base.addDeleteButton(parent);
	}

	createBonusFeats(isNew, parent) {
		if (isNew) {
			let size = main_json['character']["bonusFeats"].length;
			main_json['character']["bonusFeats"][size] = {}
		}

		base.createInput(I18n.name, "name", parent, "text");
		base.createTextArea(I18n.notes, "notes", parent);

		base.addDeleteButton(parent);
	}

	createInventory(isNew, parent) {
		if (isNew) {
			let size = main_json['character']["inventory"].length;
			main_json['character']["inventory"][size] = {}
		}

		base.createInput(I18n.name, "name", parent, "text");
		base.createInput(I18n.inventory.bulk, "bulk", parent, "number");
		base.createInput(I18n.inventory.amount, "amount", parent, "number");
		base.createTextArea(I18n.notes, "notes", parent);

		base.addDeleteButton(parent);
	}

	getValue(path) { // change name to getValue
		// [0] = character, [1] = parent, [2] = child or index, [3] = child
		// example one: character_details_name
		// example two: character_skills_1_name
		let split_path = path.split("_"); // 

		let value;
		if (Array.isArray(main_json["character"][split_path[1]])) {
			value = main_json["character"][split_path[1]][split_path[2]][split_path[3]]
		} else {
			value = main_json["character"][split_path[0]][split_path[1]]
		}

		if (value === undefined) {value = "";}
		return value;
	}

	translationSkill(skill, index) {
		let name = skill["name"];
		let translatedName = I18n.skills[name];
		main_json['character']['skills'][index]["name"] = translatedName;
	}
}