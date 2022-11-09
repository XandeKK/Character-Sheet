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

  def self.update_hp(characters)
    characters.each do |character|
      character_id = character[0]
      current_hp = character[1][:current_hp]
      temp_hp = character[1][:temp_hp]

      character_defense = Pathfinder::Defense.find_by(character_id: character_id)
      character_defense.update(
        current_hp: current_hp, temp_hp: temp_hp
      )
    end
  end

  def self.character_params params
    params.require(:character).permit(
      :character_category_id,
      pathfinder_basic_attributes: [
        :id,
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
        :id,
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
        :id,
        :platinum,
        :gold,
        :silver,
        :copper
      ],
      pathfinder_saving_throw_attributes: [
        :id,
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
        :id,
        :max_hp,
        :current_hp,
        :ancestry_hp,
        :class_hp,
        :temp_hp,
        :resistances_and_immunities,
        :conditions,
        :dying,
        :wounded,
        :max_dex,
        :armor_class_item,
        :armor_class_proficiency,
        :heavy_proficiency,
        :medium_proficiency,
        :light_proficiency,
        :unarmored_proficiency
      ],
      pathfinder_spell_caster_attributes: [
        :id,
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
        :id,
        :item,
        :proficiency,
        :senses
      ],
      pathfinder_class_dc_attributes: [
        :id,
        :item,
        :proficiency
      ],
      pathfinder_spells_attributes: [
        :id,
        :level,
        :name,
        :notes,
        :prepared,
        :spell_component,
        :duration,
        :range,
        :action,
        :_destroy
      ],
      pathfinder_melees_attributes: [
        :id,
        :name,
        :qty,
        :types,
        :proficiency,
        :traits,
        :weapon_specialization,
        :multiple_attack_penalty_2,
        :multiple_attack_penalty_3,
        :die,
        :item,
        :notes,
        :other,
        :_destroy
      ],
      pathfinder_items_attributes: [
        :id,
        :name,
        :quatity,
        :volume,
        :notes,
        :_destroy
      ],
      pathfinder_feats_attributes: [
        :id,
        :name,
        :types,
        :notes,
        :_destroy
      ],
      pathfinder_languages_attributes: [
        :id,
        :name,
        :notes,
        :_destroy
      ],
      pathfinder_rangeds_attributes: [
        :id,
        :name,
        :qty,
        :types,
        :range,
        :proficiency,
        :other,
        :traits,
        :weapon_specialization,
        :multiple_attack_penalty_2,
        :multiple_attack_penalty_3,
        :special,
        :die,
        :notes,
        :item,
        :_destroy
      ],
      pathfinder_skills_attributes: [
        :id,
        :name,
        :note,
        :proficiency,
        :key_ability,
        :item,
        :armor,
        :_destroy
      ],
      pathfinder_focus_spells_attributes: [
        :id,
        :level,
        :name,
        :notes,
        :prepared,
        :spell_component,
        :duration,
        :range,
        :action,
        :_destroy
      ],
      pathfinder_weapon_proficiencies_attributes: [
        :id,
        :name,
        :proficiency,
        :_destroy
      ],
      pathfinder_innate_spells_attributes: [
        :id,
        :name,
        :notes,
        :frequency,
        :spell_component,
        :duration,
        :range,
        :action,
        :_destroy
      ],
      pathfinder_notes_attributes: [
        :id,
        :name,
        :note,
        :_destroy
      ],
      dices_attributes: [
        :id,
        :name,
        :notation,
        :notes,
        :_destroy
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