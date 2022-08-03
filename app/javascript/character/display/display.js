class Display {
	constructor() {
		this.details();
		this.statistics();
		this.defense();
	}

	details() {
		characterName.innerText = main_json.character.details.name;
		classAndLevel.innerText = main_json.character.details.className + " " + main_json.character.details.level;
		perception.innerText = character.getPerception();
		speed.innerText = main_json.character.speed.feet + "ft";
		size.innerText = main_json.character.details.size;
		ancestry.innerText = main_json.character.details.ancestry;
		heritage.innerText = main_json.character.details.heritage;
		background.innerText = main_json.character.details.background;
		traits.innerText = main_json.character.details.traits;
		heroPoints.innerText = main_json.character.details.heroPoints;
		experiencePoints.innerText = main_json.character.details.experiencePoints;
	}

	statistics() {
		strength.innerText = "STR " + character.getAbility("strength");
		dexterity.innerText = "DEX " + character.getAbility("dexterity");
		constitution.innerText = "CON " + character.getAbility("constitution");
		intelligence.innerText = "INT " + character.getAbility("intelligence");
		wisdom.innerText = "WIS " + character.getAbility("wisdom");
		charisma.innerText = "CHA " + character.getAbility("charisma");

		strengthModifier.innerText = character.getAbilityModifier("strength");
		dexterityModifier.innerText = character.getAbilityModifier("dexterity");
		constitutionModifier.innerText = character.getAbilityModifier("constitution");
		intelligenceModifier.innerText = character.getAbilityModifier("intelligence");
		wisdomModifier.innerText = character.getAbilityModifier("wisdom");
		charismaModifier.innerText = character.getAbilityModifier("charisma");
	}

	defense() {
		hp.innerText = main_json.character.hitPoints.currentHp + "/" + main_json.character.hitPoints.maxHp;
		temporary.innerText = main_json.character.hitPoints.temporary;
		ac.innerText = character.getAC();

		resistancesAndImmunities.innerText = main_json.character.hitPoints.resistancesAndImmunities;

		fortitude.innerText = character.getSavingThrows("fortitude", "constitution") ;
		reflex.innerText = character.getSavingThrows("reflex", "dexterity");
		will.innerText = character.getSavingThrows("will", "wisdom");
	}
}