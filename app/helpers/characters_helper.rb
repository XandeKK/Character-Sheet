module CharactersHelper
	def get_name character
		character["details"]["name"]
	end

	def get_class_and_level character
		className = character["details"]["className"]
		level = character["details"]["level"].to_s
		className + " " + level
	end

	def get_speed character
		character["speed"]["feet"].to_s + "ft"
	end

	def get_size character
		character["details"]["size"]
	end

	def get_ancestry character
		character["details"]["ancestry"]
	end

	def get_heritage character
		character["details"]["heritage"]

	end

	def get_background character
		character["details"]["background"]
	end

	def get_traits character
		character["details"]["traits"]
	end

	def get_hero_points character
		character["details"]["heroPoints"]
	end

	def get_experience_points character
		character["details"]["experiencePoints"]
	end

	def get_resistances_and_immunities character
		character["hitPoints"]["resistancesAndImmunities"]
	end

	def get_current_and_max_hp character
		character["hitPoints"]["currentHp"].to_s + "/" + character["hitPoints"]["maxHp"].to_s
	end

	def get_temporary_hp character
		character["hitPoints"]["temporary"].to_s
	end

	def get_ability(name, character)
		ability = character["ability"][name]
	end

	def get_ability_modifier(name, character)
		point = get_ability(name, character).to_i
		modifier = (point/2).floor
		modifier = modifier - 5
	end

	def get_perception character
		item = character["perception"]["item"].to_i
		proficiency = character["perception"]["proficiecy"].to_i
		wisdom = get_ability_modifier("wisdom", character).to_i
		value = item + proficiency + wisdom
	end

	def get_AC character
		item = character["armorClass"]["item"].to_i
		proficiency = character["armorClass"]["proficiency"].to_i
		capable = character["armorClass"]["capable"].to_i
		capable = character["armorClass"]["capable"].to_i
		dexterity = get_ability_modifier("dexterity", character).to_i

		dexterity = capable if capable <= dexterity

		ac = item + proficiency + dexterity
	end

	def get_saving_throws(name, ability, character)
		item = character["armorClass"][name + "item"].to_i
		proficiency = character["armorClass"][name].to_i
		modifier = get_ability_modifier(ability, character).to_i
		value = item + proficiency + modifier
	end

	def attackRoll weapon
	    modifier = weapon["weaponStrength"].to_i || weapon["weaponDexterity"].to_i
	    proficiency = weapon["proficiency"].to_i
	    item = weapon["item"].to_i
	    attack = modifier + proficiency + item
	    return attack
	  end

	def getSkillModifier(skill, abilities)
		item = skill["item"].to_i
		armor = skill["armor"].to_i
		proficiency = skill["proficiency"].to_i
		ability = abilities[skill["ability"]].to_i

		abilityModifier = (ability/2).floor - 5
		skillModifier = item + armor + proficiency + abilityModifier
		skillModifier = "+" + skillModifier.to_s if skillModifier > 0

		return  skillModifier
	end

	def get_life_array characters
		json = {}
		characters.each do |character|
			if character.character_category_id == 2 || character.character_category_id == 3
			    character_json = JSON.parse(character.statistic)["character"]
			    currentHp = character_json["hitPoints"]["currentHp"]
			    temporary = character_json["hitPoints"]["temporary"]
			    maxHp = character_json["hitPoints"]["maxHp"]
			    id = character.id
			    json.store(id, {"maxHp": maxHp, "currentHp": currentHp, "temporary": temporary})
			end
	  	end
	  	return json
	end

	def get_life character
		json = {}
		character_json = JSON.parse(character.statistic)["character"]
    currentHp = character_json["hitPoints"]["currentHp"]
    temporary = character_json["hitPoints"]["temporary"]
    maxHp = character_json["hitPoints"]["maxHp"]
    id = character.id

    json.store(id, {"maxHp": maxHp, "currentHp": currentHp, "temporary": temporary})
    raw json.to_json
	end
end

