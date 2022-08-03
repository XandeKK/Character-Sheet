class CharacterUI {
	createSelectProficiency(name, id, parent) {
		let options = [
			{name: "Untrained", value: 0},
			{name: "Trained", value: 2},
			{name: "Expert", value: 4},
			{name: "Master", value: 6},
			{name: "Legendary", value: 8}
		];
		base.createSelect(name, id, parent, options)
	}

	createSelectAbility(name, id, parent) {
		let options = [
			{name: "Strength", value: "strength"},
			{name: "Dexterity", value: "dexterity"},
			{name: "Constitution", value: "constitution"},
			{name: "Intelligence", value: "intelligence"},
			{name: "Wisdom", value: "wisdom"},
			{name: "Charisma", value: "charisma"}
		];
		base.createSelect(name, id, parent, options)
	}

	createSelectDamageType(name, id, parent) {
		let options = [
			{name: "Piercing", value: "piercing"},
			{name: "Slashing", value: "slashing"},
			{name: "Budgeoning", value: "bludgeoning"}
		];
		base.createSelect(name, id, parent, options)
	}

	createWeapon(isNew, type, parent) {
		if (isNew) {
			let size = main_json['character'][type].length;
			main_json['character'][type][size] = {}
		}

		base.createInput("Weapon", "weapon", parent, "text");

		if (type == "meleeStrikes") {
			base.createInput("Weapon Strength", "weaponStrength", parent, "number");
		} else {
			base.createInput("Weapon Dexterity", "weaponDexterity", parent, "number");
		}

		this.createSelectProficiency("Proficiency", "proficiency", parent);
		base.createInput("Item", "item", parent, "number");

		base.createInput("Dice", "dice", parent, "text");
		this.createSelectDamageType("Types", "types", parent);

		if (type == "meleeStrikes") {
			base.createInput("Damage Strength", "damageStrength", parent, "text");
		} else {
			base.createInput("Special", "special", parent, "text");
			base.createInput("Range", "range", parent, "number");
		}

		base.createInput("Weapon Specialization", "weaponSpecialization", parent, "text");
		base.createInput("Traits", "traits", parent, "text");
		base.createInput("Other", "other", parent, "text");
		base.createTextArea("Notes", "notes", parent);

		base.addDeleteButton(parent);
	}

	createLanguages(isNew, parent) {
		if (isNew) {
			let size = main_json['character']["languages"].length;
			main_json['character']["languages"][size] = {}
		}

		base.createInput("Name", "name", parent, "text");
		base.createTextArea("Notes", "notes", parent);

		base.addDeleteButton(parent);
	}

	createBonusFeats(isNew, parent) {
		if (isNew) {
			let size = main_json['character']["bonusFeats"].length;
			main_json['character']["bonusFeats"][size] = {}
		}

		base.createInput("Name", "name", parent, "text");
		base.createTextArea("Notes", "notes", parent);

		base.addDeleteButton(parent);
	}

	createInventory(isNew, parent) {
		if (isNew) {
			let size = main_json['character']["inventory"].length;
			main_json['character']["inventory"][size] = {}
		}

		base.createInput("Name", "name", parent, "text");
		base.createInput("Bulk", "bulk", parent, "number");
		base.createInput("Amount", "amount", parent, "number");
		base.createTextArea("Notes", "notes", parent);

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
}