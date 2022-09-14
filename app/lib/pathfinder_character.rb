module PathfinderCharacter
  def self.create_character(user, category, character_system)
    @character = Character.new(
      user: user,
      character_category: category,
      character_system_id: character_system
    )

    if @character.save
      @character.build_pathfinder_basic(name: "Nameless").save
      @character.build_pathfinder_ability.save
      @character.build_pathfinder_money.save
      @character.build_pathfinder_saving_throw.save
      @character.build_pathfinder_defense.save
      @character.build_pathfinder_spell_caster.save
      @character.build_pathfinder_perception.save
      @character.build_pathfinder_class_dc.save
      self.create_default_skills
      self.create_default_weapon_proficiencies

      return @character
    else
      return nil
    end
  end

  def self.character_params params
    params.require(:character).permit(
      pathfinder_basic_attributes: [
        :name,
        :class_name,
        :ancestry,
        :heritage,
        :heritage_note,
        :background,
        :alignment,
        :deity,
        :key_ability,
        :age,
        :level,
        :hero_points,
        :size,
        :speed,
        :speed_note,
        :description
      ],
      pathfinder_ability_attributes: [
        :str_total,
        :str_free,
        :str_class,
        :str_ascentry,
        :str_background,
        :dex_total,
        :dex_free,
        :dex_class,
        :dex_ascentry,
        :dex_background,
        :con_total,
        :con_free,
        :con_class,
        :con_ascentry,
        :con_background,
        :int_total,
        :int_free,
        :int_class,
        :int_ascentry,
        :int_background,
        :wis_total,
        :wis_free,
        :wis_class,
        :wis_ascentry,
        :wis_background,
        :cha_total,
        :cha_free,
        :cha_class,
        :cha_ascentry,
        :cha_background
      ],
      pathfinder_money_attributes: [
        :platinum,
        :gold,
        :silver,
        :copper
      ],
      pathfinder_saving_throw_attributes: [
        :fortitude_total,
        :reflex_total,
        :will_total,
        :fortitude_proficiency,
        :reflex_proficiency,
        :will_proficiency,
        :fortitude_item,
        :reflex_item,
        :will_item,
        :fortitude_misc,
        :reflex_misc,
        :will_misc,
        :fortitude_penalty,
        :reflex_penalty,
        :will_penalty,
        :saving_throw_notes
      ],
      pathfinder_defense_attributes: [
        :max_hp,
        :current_hp,
        :ancestry_hp,
        :class_hp,
        :temp_hp,
        :resistances_and_immunities,
        :conditions,
        :dying,
        :wounded,
        :armor_class_item,
        :armor_class_proficiency,
        :heavy_proficiency,
        :medium_proficiency,
        :light_proficiency
      ],
      pathfinder_spell_caster_attributes: [
        :magic_tradition,
        :spellcasting_type,
        :attack_proficiency,
        :attack_bonus,
        :attack_penalty,
        :cd_proficiency,
        :cd_bonus,
        :cd_penalty,
        :max_focus_points,
        :current_focus_points,
        :level_0,
        :level_1,
        :level_2,
        :level_3,
        :level_4,
        :level_5,
        :level_6,
        :level_7,
        :level_8,
        :level_9,
        :level_10,
        :notes
      ],
      pathfinder_perception_attributes: [
        :item,
        :proficiency,
        :senses
      ],
      pathfinder_class_dc_attributes: [
        :item,
        :proficiency
      ],
      pathfinder_spells_attributes: [
        :level,
        :name,
        :notes,
        :prepared,
        :spell_component,
        :action
      ],
      pathfinder_melees_attributes: [
        :name,
        :qty,
        :types,
        :proficiency,
        :traits,
        :weapon_specialization,
        :die,
        :item,
        :other
      ],
      pathfinder_items_attributes: [
        :name,
        :quatity,
        :weight
      ],
      pathfinder_feats_attributes: [
        :name,
        :types,
        :notes
      ],
      pathfinder_languages_attributes: [
        :name,
        :notes
      ],
      pathfinder_rangeds_attributes: [
        :name,
        :qty,
        :types,
        :range,
        :proficiency,
        :other,
        :traits,
        :weapon_specialization,
        :special,
        :die,
        :item
      ],
      pathfinder_skills_attributes: [
        :name,
        :note,
        :proficiency,
        :key_ability,
        :item,
        :armor
      ],
      pathfinder_focus_spells_attributes: [
        :level,
        :name,
        :notes,
        :prepared,
        :spell_component,
        :action
      ],
      pathfinder_weapon_proficiencies_attributes: [
        :name,
        :proficiency
      ],
      pathfinder_innate_spells_attributes: [
        :name,
        :notes,
        :frequency,
        :spell_component,
        :action
      ],
      pathfinder_notes_attributes: [
        :name,
        :note
      ]
    )
  end

  private

  def self.create_default_skills
    @character.pathfinder_skills.create!(name: "acrobatics", key_ability: "dex")
    @character.pathfinder_skills.create!(name: "arcana", key_ability: "int")
    @character.pathfinder_skills.create!(name: "athletics", key_ability: "str")
    @character.pathfinder_skills.create!(name: "crafting", key_ability: "int")
    @character.pathfinder_skills.create!(name: "deception", key_ability: "cha")
    @character.pathfinder_skills.create!(name: "diplomacy", key_ability: "cha")
    @character.pathfinder_skills.create!(name: "intimidation", key_ability: "cha")
    @character.pathfinder_skills.create!(name: "medicine", key_ability: "wis")
    @character.pathfinder_skills.create!(name: "nature", key_ability: "wis")
    @character.pathfinder_skills.create!(name: "occultism", key_ability: "int")
    @character.pathfinder_skills.create!(name: "performance", key_ability: "cha")
    @character.pathfinder_skills.create!(name: "religion", key_ability: "wis")
    @character.pathfinder_skills.create!(name: "society", key_ability: "int")
    @character.pathfinder_skills.create!(name: "stealth", key_ability: "dex")
    @character.pathfinder_skills.create!(name: "survival", key_ability: "wis")
    @character.pathfinder_skills.create!(name: "thievery", key_ability: "dex")
    @character.pathfinder_skills.create!(name: "lore", key_ability: "")
    @character.pathfinder_skills.create!(name: "lore", key_ability: "")
  end

  def self.create_default_weapon_proficiencies
    @character.pathfinder_weapon_proficiencies.create!(name: "simple")
    @character.pathfinder_weapon_proficiencies.create!(name: "martial")
    @character.pathfinder_weapon_proficiencies.create!(name: "")
    @character.pathfinder_weapon_proficiencies.create!(name: "")
  end
end