function saveJson(event) {
	let inputs = document.querySelectorAll(".character");

	for (var i = 0; i < inputs.length; i++) {
		let path = inputs[i].id.split("_"); // 0 = character or parent, 1 = parent or child, 2 = index or child, 3 = child

		if (Array.isArray(main_json["character"][path[1]])) {
			main_json["character"][path[1]][path[2]][path[3]] = inputs[i].value;
		} else {
			main_json["character"][path[0]][path[1]] = inputs[i].value;
		}
	}

	character_statistic.value = JSON.stringify(main_json);
	setInputName();

	submit.click();
}

// Save json
button.addEventListener("click", saveJson);

// Disabling enter key for form
document.addEventListener('keypress', function (e) {
    if (e.keyCode === 13 || e.which === 13) {
        e.preventDefault();
        return false;
    }
});

function setInputName() {
	character_name.value = main_json["character"]["details"]["name"];
}

// Details
base.createDiv("details", "form");
base.createTitle("Details", "details");
base.createInput("Name", "name", "details", "text");
base.createInput("Class Name", "className", "details", "text");
base.createInput("Ancestry", "ancestry", "details", "text");
base.createInput("Heritage", "heritage", "details", "text");
base.createInput("Hero Points", "heroPoints", "details", "number");
base.createInput("Alignment", "alignment", "details", "text");
base.createInput("Size", "size", "details", "number");
base.createInput("Background", "background", "details", "text");
base.createInput("Traits", "traits", "details", "text");
base.createInput("Experience Points", "experiencePoints", "details", "number");

// Hit Points
base.createDiv("hitPoints", "form");
base.createTitle("Hit Points", "hitPoints");
base.createInput("Max Hp", "maxHp", "hitPoints", "number");
base.createInput("Current Hp", "currentHp", "hitPoints", "number");
base.createInput("Temporary", "temporary", "hitPoints", "number");
base.createInput("Resistances and Immunities", "resistancesAndImmunities", "hitPoints", "text");
base.createInput("Conditions", "conditions", "hitPoints", "text");
base.createInput("Dying", "dying", "hitPoints", "text");
base.createInput("Wounded", "wounded", "hitPoints", "text");

// Ability
base.createDiv("ability", "form");
base.createTitle("Ability", "ability");
base.createInput("Strength", "strength", "ability", "number");
base.createInput("Dexterity", "dexterity", "ability", "number");
base.createInput("Constitution", "constitution", "ability", "number");
base.createInput("Intelligence", "intelligence", "ability", "number");
base.createInput("Wisdom", "wisdom", "ability", "number");
base.createInput("Charisma", "charisma", "ability", "number");


// Armor Class
base.createDiv("armorClass", "form");
base.createTitle("Armor Class", "armorClass");
base.createInput("Capable", "capable", "armorClass", "number");
characterUI.createSelectProficiency("Armor Class", "proficiency", "armorClass")

characterUI.createSelectProficiency("Unarmored", "unarmored", "armorClass")
characterUI.createSelectProficiency("Light", "light", "armorClass")
characterUI.createSelectProficiency("Medium", "medium", "armorClass")
characterUI.createSelectProficiency("Heavy", "heavy", "armorClass")

base.createInput("Shield", "shield", "armorClass", "number");
base.createInput("Hardness", "hardness", "armorClass", "number");
base.createInput("Max Hp", "maxHp", "armorClass", "number");
base.createInput("Broken Threshold", "brokenThreshold", "armorClass", "number");
base.createInput("Current Hp", "currentHp", "armorClass", "number");

// Class Dc

base.createDiv("classDc", "form");
base.createTitle("Class Dc", "classDc");
characterUI.createSelectAbility("Key Ability", "keyAbility", "classDc")
base.createInput("Item", "item", "classDc", "number");
characterUI.createSelectProficiency("Proficiency", "proficiency", "classDc")

// Perception
base.createDiv("perception", "form");
base.createTitle("Perception", "perception");
base.createInput("Item", "item", "perception", "number");
base.createTextArea("Senses", "senses", "perception");
characterUI.createSelectProficiency("Perception", "proficiency", "perception")

// Speed
base.createDiv("speed", "form");
base.createTitle("Speed", "speed");
base.createInput("Feet", "feet", "speed", "number"); 
base.createTextArea("Movement Types", "movementTypes", "speed");
base.createTextArea("Notes", "notes", "speed");

// Saving Throws
base.createDiv("savingThrows", "form");
base.createTitle("Saving Throws", "savingThrows");
characterUI.createSelectProficiency("Fortitude", "fortitude", "savingThrows")
characterUI.createSelectProficiency("Will", "will", "savingThrows")
characterUI.createSelectProficiency("Reflex", "reflex", "savingThrows")

// Skills
base.createDiv("skills", "form");
base.createTitle("Skills", "skills");

var skills = main_json['character']['skills'];
for (let i = 0; i < skills.length; i++) {
	let id = "character_skills_" + i;
	base.createDiv(id, "skills");

	base.createInput("Name", "name", id, "text"); 
	
	characterUI.createSelectAbility("Ability", "ability", id)
	characterUI.createSelectProficiency("Proficiency", "proficiency", id)

	base.createInput("Item", "item", id, "number"); 
	base.createInput("Armor", "armor", id, "number"); 
	base.createTextArea("Notes", "notes", id);
}

// Melee Strikes Weapon
base.createDiv("meleeStrikes", "form");
base.createTitle("Melee Strikes", "meleeStrikes");

var meleeStrikes = main_json['character']['meleeStrikes'];
for (let i = 0; i < meleeStrikes.length; i++) {
	let id = "character_meleeStrikes_" + i;
	base.createDiv(id, "meleeStrikes");
	
	characterUI.createWeapon(false, "meleeStrikes", id);
}
base.addCreateButton("Melee Strikes", "meleeStrikes");

// Ranged Strikes Weapon
base.createDiv("rangedStrikes", "form");
base.createTitle("Ranged Strikes", "rangedStrikes");

var rangedStrikes = main_json['character']['rangedStrikes'];
for (let i = 0; i < rangedStrikes.length; i++) {
	let id = "character_rangedStrikes_" + i;
	base.createDiv(id, "rangedStrikes");
	
	characterUI.createWeapon(false, "rangedStrikes", id)
}
base.addCreateButton("Ranged Strikes", "rangedStrikes");

// Languages
base.createDiv("languages", "form");
base.createTitle("Languages", "languages");

var languages = main_json['character']['languages'];
for (let i = 0; i < languages.length; i++) {
	let id = "character_languages_" + i;
	base.createDiv(id, "languages");
	
	characterUI.createLanguages(false, id)
}
base.addCreateButton("Languages", "languages");

// Weapon Proficiencies
base.createDiv("weaponProficiencies", "form");
base.createTitle("Weapon Proficiencies", "weaponProficiencies");

var weaponProficiencies = main_json['character']['weaponProficiencies'];
for (let i = 0; i < weaponProficiencies.length; i++) {
	let id = "character_weaponProficiencies_" + i;
	base.createDiv(id, "weaponProficiencies");
	
	base.createInput("Name", "name", id, "text"); 
	characterUI.createSelectProficiency("Proficiency", "proficiency", id)
}

// Ancestry Feats And Abilities
base.createDiv("ancestryFeatsAndAbilities", "form");
base.createTitle("Ancestry Feats and Abilities", "ancestryFeatsAndAbilities");

var ancestryFeatsAndAbilities = main_json['character']['ancestryFeatsAndAbilities'];
for (let i = 0; i < ancestryFeatsAndAbilities.length; i++) {
	let id = "character_ancestryFeatsAndAbilities_" + i;
	base.createDiv(id, "ancestryFeatsAndAbilities");
	
	base.createInput("Level", "level", id, "text"); 
	base.createInput("Name", "name", id, "text"); 
	base.createTextArea("Notes", "notes", id);
}

// Skill Feats
base.createDiv("skillFeats", "form");
base.createTitle("Skill Feats", "skillFeats");

var skillFeats = main_json['character']['skillFeats'];
for (let i = 0; i < skillFeats.length; i++) {
	let id = "character_skillFeats_" + i;
	base.createDiv(id, "skillFeats");
	
	base.createInput("Level", "level", id, "text"); 
	base.createInput("Name", "name", id, "text"); 
	base.createTextArea("Notes", "notes", id);
}

// Class Feats And Abilities
base.createDiv("classFeatsAndAbilities", "form");
base.createTitle("Class Feats and Abilities", "classFeatsAndAbilities");

var classFeatsAndAbilities = main_json['character']['classFeatsAndAbilities'];
for (let i = 0; i < classFeatsAndAbilities.length; i++) {
	let id = "character_classFeatsAndAbilities_" + i;
	base.createDiv(id, "classFeatsAndAbilities");
	
	base.createInput("Level", "level", id, "text"); 
	base.createInput("Name", "name", id, "text"); 
	base.createTextArea("Notes", "notes", id);
}

// General Feats
base.createDiv("generalFeats", "form");
base.createTitle("General Feats", "generalFeats");

var generalFeats = main_json['character']['generalFeats'];
for (let i = 0; i < generalFeats.length; i++) {
	let id = "character_generalFeats_" + i;
	base.createDiv(id, "generalFeats");
	
	base.createInput("Level", "level", id, "text"); 
	base.createInput("Name", "name", id, "text"); 
	base.createTextArea("Notes", "notes", id);
}

// Bonus Feats
base.createDiv("bonusFeats", "form");
base.createTitle("Bonus Feats", "bonusFeats");

var bonusFeats = main_json['character']['bonusFeats'];
for (let i = 0; i < bonusFeats.length; i++) {
	let id = "character_bonusFeats_" + i;
	base.createDiv(id, "bonusFeats");
	
	characterUI.createBonusFeats(false, id)
}
base.addCreateButton("Bonus Feats", "bonusFeats");

// Inventory
base.createDiv("inventory", "form");
base.createTitle("Inventory", "inventory");

var inventory = main_json['character']['inventory'];
for (let i = 0; i < inventory.length; i++) {
	let id = "character_inventory_" + i;
	base.createDiv(id, "inventory");

	characterUI.createInventory(false, id)
}
base.addCreateButton("Inventory", "inventory");

// Money
base.createDiv("money", "form");
base.createTitle("Money", "money");

base.createInput("pp", "pp", "money", "number"); 
base.createInput("gp", "gp", "money", "number"); 
base.createInput("sp", "sp", "money", "number"); 
base.createInput("cp", "cp", "money", "number"); 