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
	setImage();
}

// Save json
submit.addEventListener("click", saveJson);

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

function setImage() {
	vanilla.result({type: 'base64', size: {width:300, height:300}}).then(function(base64) {
      	character_character_image.setAttribute("value", base64);
    });
}

base.createCardTab("basics", "Basics",[
	{"id": "details", "name": "Details"},
	{"id": "perception", "name": "Perception"},
	{"id": "speed", "name": "Speed"},
	{"id": "languages", "name": "Languages"},
]);

base.createCardTab("statistics", "Statistics", [
	{"id": "ability", "name": "Ability"},
	{"id": "classDc", "name": "Class DC"},
]);

base.createCardTab("defense", "Defense", [
	{"id": "hitPoints", "name": "HP"},
	{"id": "armorClass", "name": "AC"},
	{"id": "savingThrows", "name": "Saving Throws"},
]);

base.createCardTab("offense", "Offense", [
	{"id": "meleeStrikes", "name": "Melee Strikes"},
	{"id": "rangedStrikes", "name": "Ranged Strikes"},
	{"id": "weaponProficiencies", "name": "Weapon Proficiencies"},
]);

base.createCardTab("skills", "Skills", [
	{"id": "skills", "name": "Skills"},
	{"id": "skillFeats", "name": "Skill Feats"},
	{"id": "ancestryFeatsAndAbilities", "name": "Ancestry Feats"},
	{"id": "classFeatsAndAbilities", "name": "Class Feats"},
	{"id": "generalFeats", "name": "General Feats"},
	{"id": "bonusFeats", "name": "Bonus Feats"},
]);

base.createCardTab("inventory", "Inventory", [
	{"id": "inventory", "name": "Inventory"},
	{"id": "money", "name": "Money"}
]);

// Details
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
base.createInput("Max Hp", "maxHp", "hitPoints", "number");
base.createInput("Current Hp", "currentHp", "hitPoints", "number");
base.createInput("Temporary", "temporary", "hitPoints", "number");
base.createInput("Resistances and Immunities", "resistancesAndImmunities", "hitPoints", "text");

// Ability
base.createInput("Strength", "strength", "ability", "number");
base.createInput("Dexterity", "dexterity", "ability", "number");
base.createInput("Constitution", "constitution", "ability", "number");
base.createInput("Intelligence", "intelligence", "ability", "number");
base.createInput("Wisdom", "wisdom", "ability", "number");
base.createInput("Charisma", "charisma", "ability", "number");


// Armor Class
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
base.createInput("Item", "item", "armorClass", "number");

// Class Dc

characterUI.createSelectAbility("Key Ability", "keyAbility", "classDc")
base.createInput("Item", "item", "classDc", "number");
characterUI.createSelectProficiency("Proficiency", "proficiency", "classDc")

// Perception

base.createInput("Item", "item", "perception", "number");
characterUI.createSelectProficiency("Perception", "proficiency", "perception")
base.createTextArea("Senses", "senses", "perception");

// Speed
base.createInput("Feet", "feet", "speed", "number"); 
base.createTextArea("Movement Types", "movementTypes", "speed");
base.createTextArea("Notes", "notes", "speed");

// Saving Throws
characterUI.createSelectProficiency("Fortitude", "fortitude", "savingThrows")
base.createInput("FortitudeItem", "fortitudeItem", "savingThrows", "number"); 
characterUI.createSelectProficiency("Will", "will", "savingThrows")
base.createInput("Will", "willItem", "savingThrows", "number"); 
characterUI.createSelectProficiency("Reflex", "reflex", "savingThrows")
base.createInput("Reflex", "reflexItem", "savingThrows", "number"); 

// Skills

var skills = main_json['character']['skills'];
for (let i = 0; i < skills.length; i++) {
	let id = "character_skills_" + i;
	base.createDiv(id, "skills", "row gx-3 gy-2 align-items-center mb-3 pb-4");

	base.createInput("Name", "name", id, "text"); 
	
	characterUI.createSelectAbility("Ability", "ability", id)
	characterUI.createSelectProficiency("Proficiency", "proficiency", id)

	base.createInput("Item", "item", id, "number"); 
	base.createInput("Armor", "armor", id, "number"); 
	base.createTextArea("Notes", "notes", id);
}

// Melee Strikes Weapon
base.addCreateButton("Melee Strikes", "meleeStrikes");

var meleeStrikes = main_json['character']['meleeStrikes'];
for (let i = 0; i < meleeStrikes.length; i++) {
	let id = "character_meleeStrikes_" + i;
	base.createDiv(id, "meleeStrikes", "row gx-3 gy-2 align-items-center mb-3 pb-4");
	
	characterUI.createWeapon(false, "meleeStrikes", id);
}

// Ranged Strikes Weapon
base.addCreateButton("Ranged Strikes", "rangedStrikes");

var rangedStrikes = main_json['character']['rangedStrikes'];
for (let i = 0; i < rangedStrikes.length; i++) {
	let id = "character_rangedStrikes_" + i;
	base.createDiv(id, "rangedStrikes", "row gx-3 gy-2 align-items-center mb-3 pb-4");
	
	characterUI.createWeapon(false, "rangedStrikes", id)
}

// Languages
base.addCreateButton("Languages", "languages");

var languages = main_json['character']['languages'];
for (let i = 0; i < languages.length; i++) {
	let id = "character_languages_" + i;
	base.createDiv(id, "languages", "row gx-3 gy-2 align-items-center mb-3 pb-4");
	
	characterUI.createLanguages(false, id)
}

// Weapon Proficiencies

var weaponProficiencies = main_json['character']['weaponProficiencies'];
for (let i = 0; i < weaponProficiencies.length; i++) {
	let id = "character_weaponProficiencies_" + i;
	base.createDiv(id, "weaponProficiencies", "row gx-3 gy-2 align-items-center mb-3 pb-4");
	
	base.createInput("Name", "name", id, "text"); 
	characterUI.createSelectProficiency("Proficiency", "proficiency", id)
}

// Ancestry Feats And Abilities

var ancestryFeatsAndAbilities = main_json['character']['ancestryFeatsAndAbilities'];
for (let i = 0; i < ancestryFeatsAndAbilities.length; i++) {
	let id = "character_ancestryFeatsAndAbilities_" + i;
	base.createDiv(id, "ancestryFeatsAndAbilities", "row gx-3 gy-2 align-items-center mb-3 pb-4");
	
	base.createInput("Level", "level", id, "text"); 
	base.createInput("Name", "name", id, "text"); 
	base.createTextArea("Notes", "notes", id);
}

// Skill Feats

var skillFeats = main_json['character']['skillFeats'];
for (let i = 0; i < skillFeats.length; i++) {
	let id = "character_skillFeats_" + i;
	base.createDiv(id, "skillFeats", "row gx-3 gy-2 align-items-center mb-3 pb-4");
	
	base.createInput("Level", "level", id, "text"); 
	base.createInput("Name", "name", id, "text"); 
	base.createTextArea("Notes", "notes", id);
}

// Class Feats And Abilities

var classFeatsAndAbilities = main_json['character']['classFeatsAndAbilities'];
for (let i = 0; i < classFeatsAndAbilities.length; i++) {
	let id = "character_classFeatsAndAbilities_" + i;
	base.createDiv(id, "classFeatsAndAbilities", "row gx-3 gy-2 align-items-center mb-3 pb-4");
	
	base.createInput("Level", "level", id, "text"); 
	base.createInput("Name", "name", id, "text"); 
	base.createTextArea("Notes", "notes", id);
}

// General Feats

var generalFeats = main_json['character']['generalFeats'];
for (let i = 0; i < generalFeats.length; i++) {
	let id = "character_generalFeats_" + i;
	base.createDiv(id, "generalFeats", "row gx-3 gy-2 align-items-center mb-3 pb-4");
	
	base.createInput("Level", "level", id, "text"); 
	base.createInput("Name", "name", id, "text"); 
	base.createTextArea("Notes", "notes", id);
}

// Bonus Feats
base.addCreateButton("Bonus Feats", "bonusFeats");

var bonusFeats = main_json['character']['bonusFeats'];
for (let i = 0; i < bonusFeats.length; i++) {
	let id = "character_bonusFeats_" + i;
	base.createDiv(id, "bonusFeats", "row gx-3 gy-2 align-items-center mb-3 pb-4");
	
	characterUI.createBonusFeats(false, id)
}

// Inventory
base.addCreateButton("Inventory", "inventory");

var inventory = main_json['character']['inventory'];
for (let i = 0; i < inventory.length; i++) {
	let id = "character_inventory_" + i;
	base.createDiv(id, "inventory", "row gx-3 gy-2 align-items-center mb-3 pb-3");

	characterUI.createInventory(false, id)
}

// Money

base.createInput("pp", "pp", "money", "number"); 
base.createInput("gp", "gp", "money", "number"); 
base.createInput("sp", "sp", "money", "number"); 
base.createInput("cp", "cp", "money", "number"); 