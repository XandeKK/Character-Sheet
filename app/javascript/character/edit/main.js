const base = new BaseUI();
const characterUI = new CharacterUI();

// Disabling enter key for form
document.addEventListener('keypress', function (e) {
    if (e.keyCode === 13 || e.which === 13) {
        e.preventDefault();
        return false;
    }
});

base.createCardTab("basics", I18n.basics.title,[
	{"id": "details", "name": I18n.details},
	{"id": "perception", "name": I18n.basics.perception},
	{"id": "speed", "name": I18n.basics.speed},
	{"id": "languages", "name": I18n.statistics.languages},
]);

base.createCardTab("statistics", I18n.statistics.title, [
	{"id": "ability", "name": I18n.statistics.ability.title},
	{"id": "classDc", "name": I18n.statistics["class dc"]},
]);

base.createCardTab("defense", I18n.defense.title, [
	{"id": "hitPoints", "name": I18n.defense.hp},
	{"id": "armorClass", "name": I18n.defense.ac},
	{"id": "savingThrows", "name": I18n.defense["saving throws"].title},
]);

base.createCardTab("offense", I18n.offense.title, [
	{"id": "meleeStrikes", "name": I18n.offense["melee strikes"]},
	{"id": "rangedStrikes", "name": I18n.offense["ranged strikes"]},
	{"id": "weaponProficiencies", "name": I18n.offense["weapon proficiencies"]},
]);

base.createCardTab("skills", I18n.skills.title, [
	{"id": "skills", "name": I18n.skills.title},
	{"id": "skillFeats", "name": I18n.skills["skill feats"]},
	{"id": "ancestryFeatsAndAbilities", "name": I18n.skills["ancestry feats"]},
	{"id": "classFeatsAndAbilities", "name": I18n.skills["class feats"]},
	{"id": "generalFeats", "name": I18n.skills["general feats"]},
	{"id": "bonusFeats", "name": I18n.skills["bonus feats"]},
]);

base.createCardTab("inventory", I18n.inventory.title, [
	{"id": "inventory", "name": I18n.inventory.title},
	{"id": "money", "name": I18n.inventory.money}
]);

// Details
base.createInput(I18n.name, "name", "details", "text");
base.createInput(I18n.basics["class name"], "className", "details", "text");
base.createInput(I18n.basics.ancestry, "ancestry", "details", "text");
base.createInput(I18n.basics.heritage, "heritage", "details", "text");
base.createInput(I18n.basics["hero points"], "heroPoints", "details", "number");
base.createInput(I18n.basics.alignment, "alignment", "details", "text");
base.createInput(I18n.basics.size, "size", "details", "number");
base.createInput(I18n.basics.background, "background", "details", "text");
base.createInput(I18n.traits, "traits", "details", "text");
base.createInput(I18n.basics["experience"], "experiencePoints", "details", "number");
base.createInput(I18n.skills.level, "level", "details", "number");

// Hit Points
base.createInput(I18n.defense["max hp"], "maxHp", "hitPoints", "number");
base.createInput(I18n.defense["current hp"], "currentHp", "hitPoints", "number");
base.createInput(I18n.defense["temporary hp"], "temporary", "hitPoints", "number");
base.createInput(I18n.defense["resistances and immunities"], "resistancesAndImmunities", "hitPoints", "text");

// Ability
base.createInput(I18n.statistics.ability.strength, "strength", "ability", "number");
base.createInput(I18n.statistics.ability.dexterity, "dexterity", "ability", "number");
base.createInput(I18n.statistics.ability.constitution, "constitution", "ability", "number");
base.createInput(I18n.statistics.ability.intelligence, "intelligence", "ability", "number");
base.createInput(I18n.statistics.ability.wisdom, "wisdom", "ability", "number");
base.createInput(I18n.statistics.ability.charisma, "charisma", "ability", "number");


// Armor Class
base.createInput(I18n.defense.capable, "capable", "armorClass", "number");
characterUI.createSelectProficiency(I18n.defense["armor class"], "proficiency", "armorClass")

characterUI.createSelectProficiency(I18n.defense.unarmored, "unarmored", "armorClass")
characterUI.createSelectProficiency(I18n.defense.light, "light", "armorClass")
characterUI.createSelectProficiency(I18n.defense.medium, "medium", "armorClass")
characterUI.createSelectProficiency(I18n.defense.heavy, "heavy", "armorClass")

base.createInput(I18n.defense.shield, "shield", "armorClass", "number");
base.createInput(I18n.defense.hardness, "hardness", "armorClass", "number");
base.createInput(I18n.defense["max hp"], "maxHp", "armorClass", "number");
base.createInput(I18n.defense["broken threshold"], "brokenThreshold", "armorClass", "number");
base.createInput(I18n.defense["current hp"], "currentHp", "armorClass", "number");
base.createInput(I18n.item, "item", "armorClass", "number");

// Class Dc

characterUI.createSelectAbility(I18n.statistics["key ability"], "keyAbility", "classDc")
base.createInput(I18n.item, "item", "classDc", "number");
characterUI.createSelectProficiency(I18n.proficiency.title, "proficiency", "classDc")

// Perception

base.createInput(I18n.item, "item", "perception", "number");
characterUI.createSelectProficiency(I18n.basics.perception, "proficiency", "perception")
base.createTextArea(I18n.basics.senses, "senses", "perception");

// Speed
base.createInput(I18n.feet, "feet", "speed", "number"); 
base.createTextArea(I18n.basics["movement types"], "movementTypes", "speed");
base.createTextArea(I18n.notes, "notes", "speed");

// Saving Throws
characterUI.createSelectProficiency(I18n.defense["saving throws"].fortitude, "fortitude", "savingThrows")
base.createInput(I18n.defense["saving throws"].fortitude + " " + I18n.item, "fortitudeItem", "savingThrows", "number"); 
characterUI.createSelectProficiency(I18n.defense["saving throws"].will, "will", "savingThrows")
base.createInput(I18n.defense["saving throws"].will + " " + I18n.item, "willItem", "savingThrows", "number"); 
characterUI.createSelectProficiency(I18n.defense["saving throws"].reflex, "reflex", "savingThrows")
base.createInput(I18n.defense["saving throws"].reflex + " " + I18n.item, "reflexItem", "savingThrows", "number"); 

// Skills

var skills = main_json['character']['skills'];
for (let i = 0; i < skills.length; i++) {
	characterUI.translationSkill(skills[i], i);

	let id = "character_skills_" + i;
	base.createDiv(id, "skills", "row gx-3 gy-2 align-items-center mb-3 pb-4");

	base.createInput(I18n.name, "name", id, "text"); 
	
	characterUI.createSelectAbility(I18n.statistics.ability.title, "ability", id)
	characterUI.createSelectProficiency(I18n.proficiency.title, "proficiency", id)

	base.createInput(I18n.item, "item", id, "number"); 
	base.createInput(I18n.defense.armor, "armor", id, "number"); 
	base.createTextArea(I18n.notes, "notes", id);
}

// Melee Strikes Weapon
base.addCreateButton(I18n.offense["melee strikes"], "meleeStrikes");

var meleeStrikes = main_json['character']['meleeStrikes'];
for (let i = 0; i < meleeStrikes.length; i++) {
	let id = "character_meleeStrikes_" + i;
	base.createDiv(id, "meleeStrikes", "row gx-3 gy-2 align-items-center mb-3 pb-4");
	
	characterUI.createWeapon(false, "meleeStrikes", id);
}

// Ranged Strikes Weapon
base.addCreateButton(I18n.offense["ranged strikes"], "rangedStrikes");

var rangedStrikes = main_json['character']['rangedStrikes'];
for (let i = 0; i < rangedStrikes.length; i++) {
	let id = "character_rangedStrikes_" + i;
	base.createDiv(id, "rangedStrikes", "row gx-3 gy-2 align-items-center mb-3 pb-4");
	
	characterUI.createWeapon(false, "rangedStrikes", id)
}

// Languages
base.addCreateButton(I18n.statistics.languages, "languages");

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
	
	base.createInput(I18n.name, "name", id, "text"); 
	characterUI.createSelectProficiency(I18n.proficiency.title, "proficiency", id)
}

// Ancestry Feats And Abilities

var ancestryFeatsAndAbilities = main_json['character']['ancestryFeatsAndAbilities'];
for (let i = 0; i < ancestryFeatsAndAbilities.length; i++) {
	let id = "character_ancestryFeatsAndAbilities_" + i;
	base.createDiv(id, "ancestryFeatsAndAbilities", "row gx-3 gy-2 align-items-center mb-3 pb-4");
	
	base.createInput(I18n.skills.level, "level", id, "text"); 
	base.createInput(I18n.name, "name", id, "text"); 
	base.createTextArea(I18n.notes, "notes", id);
}

// Skill Feats

var skillFeats = main_json['character']['skillFeats'];
for (let i = 0; i < skillFeats.length; i++) {
	let id = "character_skillFeats_" + i;
	base.createDiv(id, "skillFeats", "row gx-3 gy-2 align-items-center mb-3 pb-4");
	
	base.createInput(I18n.skills.level, "level", id, "text"); 
	base.createInput(I18n.name, "name", id, "text"); 
	base.createTextArea(I18n.notes, "notes", id);
}

// Class Feats And Abilities

var classFeatsAndAbilities = main_json['character']['classFeatsAndAbilities'];
for (let i = 0; i < classFeatsAndAbilities.length; i++) {
	let id = "character_classFeatsAndAbilities_" + i;
	base.createDiv(id, "classFeatsAndAbilities", "row gx-3 gy-2 align-items-center mb-3 pb-4");
	
	base.createInput(I18n.skills.level, "level", id, "text"); 
	base.createInput(I18n.name, "name", id, "text"); 
	base.createTextArea(I18n.notes, "notes", id);
}

// General Feats

var generalFeats = main_json['character']['generalFeats'];
for (let i = 0; i < generalFeats.length; i++) {
	let id = "character_generalFeats_" + i;
	base.createDiv(id, "generalFeats", "row gx-3 gy-2 align-items-center mb-3 pb-4");
	
	base.createInput(I18n.skills.level, "level", id, "text"); 
	base.createInput(I18n.name, "name", id, "text"); 
	base.createTextArea(I18n.notes, "notes", id);
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
base.addCreateButton(I18n.inventory.title, "inventory");

var inventory = main_json['character']['inventory'];
for (let i = 0; i < inventory.length; i++) {
	let id = "character_inventory_" + i;
	base.createDiv(id, "inventory", "row gx-3 gy-2 align-items-center mb-3 pb-3");

	characterUI.createInventory(false, id)
}

// Money

base.createInput(I18n.inventory.pp, "pp", "money", "number"); 
base.createInput(I18n.inventory.gp, "gp", "money", "number"); 
base.createInput(I18n.inventory.sp, "sp", "money", "number"); 
base.createInput(I18n.inventory.cp, "cp", "money", "number"); 