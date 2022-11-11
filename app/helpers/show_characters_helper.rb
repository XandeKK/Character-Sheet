module ShowCharactersHelper
  def get_score_level(character, proficiency)
    proficiency > 0 ? character.pathfinder_basic.level.to_i : 0
  end

  def get_perception character
    modifier = get_modifier(character, 'wis')
    item = character.pathfinder_perception.item || 0
    proficiency = character.pathfinder_perception.proficiency || 0
    level = get_score_level(character, proficiency)

    modifier + item + proficiency + level
  end

  def get_modifier(character, ability)
    score = character.pathfinder_ability["#{ability}_total"] || 0
    ((score/2) - 5).floor
  end

  def get_armor_class character
    dex = get_modifier(character, "dex")
    item = character.pathfinder_defense.armor_class_item || 0
    proficiency = character.pathfinder_defense.armor_class_proficiency || 0
    level = get_score_level(character, proficiency)
    max_dex = character.pathfinder_defense.max_dex

    dex = max_dex if !max_dex.nil? && dex > max_dex

    10 + dex + item + proficiency + level
  end

  def key_ability?(character, ability)
    if character.pathfinder_basic.key_ability == ability
      "bg-rose-300/50 dark:bg-rose-700/30"
    end
  end

  def get_volume(character)
    volume = character.pathfinder_items.map(&:volume).inject {|sum, n| sum + n}
    0 if volume.nil?
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
    level = get_score_level(character, proficiency)

    attack = str + item + proficiency + level

    format_number(attack)
  end

  def get_second_attack_melee(character, weapon)
    str = get_modifier(character, "str")
    item = weapon.item || 0
    proficiency = weapon.proficiency || 0
    level = get_score_level(character, proficiency)
    penalty = weapon.multiple_attack_penalty_2 || -5

    attack = str + item + proficiency + penalty + level

    format_number(attack)
  end

  def get_third_attack_melee(character, weapon)
    str = get_modifier(character, "str")
    item = weapon.item || 0
    proficiency = weapon.proficiency || 0
    level = get_score_level(character, proficiency)
    penalty = weapon.multiple_attack_penalty_3 || -10

    attack = str + item + proficiency + penalty + level

    format_number(attack)
  end

  def bonus_damage_melee(character, weapon)
    str = get_modifier(character, "str")
    weapon_specialization = weapon.weapon_specialization || 0

    bonus = str + weapon_specialization

    format_number(bonus)
  end

  def get_attack_ranged(character, weapon)
    dex = get_modifier(character, "dex")
    item = weapon.item || 0
    proficiency = weapon.proficiency || 0
    level = get_score_level(character, proficiency)

    attack = dex + item + proficiency + level

    format_number(attack)
  end

  def get_second_attack_ranged(character, weapon)
    dex = get_modifier(character, "dex")
    item = weapon.item || 0
    proficiency = weapon.proficiency || 0
    level = get_score_level(character, proficiency)
    penalty = weapon.multiple_attack_penalty_2 || -5

    attack = dex + item + proficiency + penalty + level

    format_number(attack)
  end

  def get_third_attack_ranged(character, weapon)
    dex = get_modifier(character, "dex")
    item = weapon.item || 0
    proficiency = weapon.proficiency || 0
    level = get_score_level(character, proficiency)
    penalty = weapon.multiple_attack_penalty_3 || -10

    attack = dex + item + proficiency + penalty + level

    format_number(attack)
  end

  def bonus_damage_ranged weapon
    weapon_specialization = weapon.weapon_specialization || 0
    special = weapon.special || 0

    bonus = special + weapon_specialization

    format_number(bonus)
  end

  def score_skill(character, skill)
    ability = get_modifier(character, skill.key_ability)
    item = skill.item || 0
    proficiency = skill.proficiency || 0
    level = get_score_level(character, proficiency)
    armor = skill.armor || 0

    ability + item + proficiency - armor.abs + level
  end

  def get_attack_spell character
    ability = get_modifier(character, character.pathfinder_basic.key_ability)
    proficiency = character.pathfinder_spell_caster.attack_proficiency || 0
    level = get_score_level(character, proficiency)
    bonus = character.pathfinder_spell_caster.attack_bonus || 0
    penalty = character.pathfinder_spell_caster.attack_penalty || 0

    ability + proficiency + bonus - penalty + level
  end

  def get_cd_spell character
    ability = get_modifier(character, character.pathfinder_basic.key_ability)
    proficiency = character.pathfinder_spell_caster.cd_proficiency || 0
    level = get_score_level(character, proficiency)
    bonus = character.pathfinder_spell_caster.cd_bonus || 0
    penalty = character.pathfinder_spell_caster.cd_penalty || 0

    10 + ability + proficiency + bonus - penalty + level
  end

  def format_macro_notation(character, macro)
    str = get_modifier(character, :str)
    dex = get_modifier(character, :dex)
    con = get_modifier(character, :con)
    int = get_modifier(character, :int)
    wis = get_modifier(character, :wis)
    cha = get_modifier(character, :cha)
    level = character.pathfinder_basic.level || "0"

    macro.gsub! "str", str.to_s
    macro.gsub! "dex", dex.to_s
    macro.gsub! "con", con.to_s
    macro.gsub! "int", int.to_s
    macro.gsub! "wis", wis.to_s
    macro.gsub! "cha", cha.to_s
    macro.gsub! "level", level.to_s

    macro
  end

  private
  def format_number number
    if number > 0
      "+#{number.abs}"
    elsif number < 0
      "-#{number.abs}"
    else
      number
    end
  end
end