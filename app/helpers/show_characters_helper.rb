module ShowCharactersHelper
  def get_perception
    modifier = get_modifier('wis')
    item = @character.pathfinder_perception.item || 0
    proficiency = @character.pathfinder_perception.proficiency || 0

    modifier + item + proficiency
  end

  def get_modifier(ability)
    score = @character.pathfinder_ability["#{ability}_total"] || 0
    ((score/2) - 5).floor
  end

  def get_armor_class
    dex = get_modifier("dex")
    item = @character.pathfinder_defense.armor_class_item || 0
    proficiency = @character.pathfinder_defense.armor_class_proficiency || 0
    max_dex = @character.pathfinder_defense.max_dex

    dex = max_dex if !max_dex.nil? && dex > max_dex

    10 + dex + item + proficiency
  end

  def key_ability? ability
    if @character.pathfinder_basic.key_ability == ability
      "bg-rose-300/50 dark:bg-rose-700/30"
    else
      ""
    end
  end

  def get_volume
    @character.pathfinder_items.map(&:volume).inject(0, :+)
  end

  def get_total_gold
    copper = @character.pathfinder_money.copper || 0
    silver = @character.pathfinder_money.silver || 0
    gold = @character.pathfinder_money.gold || 0
    platinum = @character.pathfinder_money.platinum || 0

    total = 0

    total += (copper/100);
    total += (silver/10);
    total += (platinum*10);
    total += gold
  end

  def get_attack_melee weapon
    str = get_modifier "str"
    item = weapon.item || 0
    proficiency = weapon.proficiency || 0

    str + item + proficiency
  end

  def bonus_damage_melee weapon
    str = get_modifier "str"
    weapon_specialization = weapon.weapon_specialization || 0

    bonus = str + weapon_specialization

    if bonus > 0
      "+ #{bonus}" 
    else
      "- #{bonus.abs}"
    end
  end

  def get_attack_ranged weapon
    dex = get_modifier "dex"
    item = weapon.item || 0
    proficiency = weapon.proficiency || 0

    dex + item + proficiency
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

  def score_skill skill
    ability = get_modifier skill.key_ability
    item = skill.item || 0
    proficiency = skill.proficiency || 0
    armor = skill.armor || 0

    ability + item + proficiency - armor
  end
end