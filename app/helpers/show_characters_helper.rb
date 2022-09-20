module ShowCharactersHelper
  def get_perception character
    modifier = get_modifier(character, 'wis')
    item = character.pathfinder_perception.item || 0
    proficiency = character.pathfinder_perception.proficiency || 0

    modifier + item + proficiency
  end

  def get_modifier(character, ability)
    score = character.pathfinder_ability["#{ability}_total"] || 0
    ((score/2) - 5).floor
  end

  def get_armor_class character
    dex = get_modifier(character, "dex")
    item = character.pathfinder_defense.armor_class_item || 0
    proficiency = character.pathfinder_defense.armor_class_proficiency || 0
    max_dex = character.pathfinder_defense.max_dex

    dex = max_dex if !max_dex.nil? && dex > max_dex

    10 + dex + item + proficiency
  end

  def key_ability?(character, ability)
    if character.pathfinder_basic.key_ability == ability
      "bg-rose-300/50 dark:bg-rose-700/30"
    else
      ""
    end
  end

  def get_volume(character)
    character.pathfinder_items.map(&:volume).inject(0, :+)
  end

  def get_total_gold character
    copper = character.pathfinder_money.copper || 0
    silver = character.pathfinder_money.silver || 0
    gold = character.pathfinder_money.gold || 0
    platinum = character.pathfinder_money.platinum || 0

    total = 0

    total += (copper/100);
    total += (silver/10);
    total += (platinum*10);
    total += gold
  end

  def get_attack_melee(character, weapon)
    str = get_modifier(character, "str")
    item = weapon.item || 0
    proficiency = weapon.proficiency || 0

    str + item + proficiency
  end

  def get_second_attack_melee(character, weapon)
    str = get_modifier(character, "str")
    item = weapon.item || 0
    proficiency = weapon.proficiency || 0
    penalty = weapon.multiple_attack_penalty_2 || -5

    str + item + proficiency + penalty
  end

  def get_third_attack_melee(character, weapon)
    str = get_modifier(character, "str")
    item = weapon.item || 0
    proficiency = weapon.proficiency || 0
    penalty = weapon.multiple_attack_penalty_3 || -10

    str + item + proficiency + penalty
  end

  def bonus_damage_melee(character, weapon)
    str = get_modifier(character, "str")
    weapon_specialization = weapon.weapon_specialization || 0

    bonus = str + weapon_specialization

    if bonus > 0
      "+ #{bonus}" 
    else
      "- #{bonus.abs}"
    end
  end

  def get_attack_ranged(character, weapon)
    dex = get_modifier(character, "dex")
    item = weapon.item || 0
    proficiency = weapon.proficiency || 0

    dex + item + proficiency
  end

  def get_second_attack_ranged(character, weapon)
    dex = get_modifier(character, "dex")
    item = weapon.item || 0
    proficiency = weapon.proficiency || 0
    penalty = weapon.multiple_attack_penalty_2 || -5

    dex + item + proficiency + penalty
  end

  def get_third_attack_ranged(character, weapon)
    dex = get_modifier(character, "dex")
    item = weapon.item || 0
    proficiency = weapon.proficiency || 0
    penalty = weapon.multiple_attack_penalty_3 || -10

    dex + item + proficiency + penalty
  end

  def bonus_damage_ranged weapon
    weapon_specialization = weapon.weapon_specialization || 0
    special = weapon.special || 0

    bonus = special + weapon_specialization

    if bonus > 0
      "+ #{bonus}" 
    else
      "- #{bonus.abs}"
    end
  end

  def score_skill(character, skill)
    ability = get_modifier(character, skill.key_ability)
    item = skill.item || 0
    proficiency = skill.proficiency || 0
    armor = skill.armor || 0

    ability + item + proficiency - armor
  end

  def get_attack_spell character
    ability = get_modifier(character, character.pathfinder_basic.key_ability)
    proficiency = character.pathfinder_spell_caster.attack_proficiency || 0
    bonus = character.pathfinder_spell_caster.attack_bonus || 0
    penalty = character.pathfinder_spell_caster.attack_penalty || 0

    ability + proficiency + bonus - penalty
  end

  def get_cd_spell character
    ability = get_modifier(character, character.pathfinder_basic.key_ability)
    proficiency = character.pathfinder_spell_caster.cd_proficiency || 0
    bonus = character.pathfinder_spell_caster.cd_bonus || 0
    penalty = character.pathfinder_spell_caster.cd_penalty || 0

    10 + ability + proficiency + bonus - penalty
  end
end