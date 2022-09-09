module PathfinderCharacter
  def self.create_character(user, category, character_system)
    @character = Character.new(
      user: user,
      character_category: category,
      character_system_id: character_system
    )

    if @character.save
      @character.build_pathfinder_detail(name: "Nameless").save
      @character.build_pathfinder_hit_point.save
      @character.build_pathfinder_ability.save
      @character.build_pathfinder_armor_class.save
      @character.build_pathfinder_class_dc.save
      @character.build_pathfinder_perception.save
      @character.build_pathfinder_speed.save
      @character.build_pathfinder_saving_throw.save
      @character.build_pathfinder_money.save
      
      return @character
    else
      return nil
    end
  end

  def self.character_params params
    params.require(:character).permit(
      pathfinder_detail_attributes: [
        :name,
        :class_name,
        :ancestry,
        :heritage,
        :alignment,
        :background,
        :traits,
        :level,
        :hero_points,
        :size,
        :experience_points,
      ],
      pathfinder_hit_point_attributes: [
        :max_hp,
        :current_hp,
        :temporary_hp,
        :resistances_and_immunities
      ],
      pathfinder_ability_attributes: [
        :strength,
        :dexterity,
        :constitution,
        :intelligence,
        :wisdom,
        :charisma
      ],
      pathfinder_armor_class_attributes: [
        :capable,
        :proficiency,
        :unarmored,
        :light,
        :medium,
        :heavy,
        :shield,
        :hardness,
        :maxHp,
        :broken_threshold,
        :current_hp,
        :item
      ],
      pathfinder_class_dc_attributes: [
        :key_ability,
        :item,
        :proficiency
      ],
      pathfinder_perception_attributes: [
        :item,
        :senses,
        :proficiency
      ],
      pathfinder_speed_attributes: [
        :feet,
        :movement_types,
        :notes
      ],
      pathfinder_saving_throw_attributes: [
        :fortitude,
        :fortitude_item,
        :will,
        :will_item,
        :reflex,
        :reflex_item
      ],
      pathfinder_skills_attributes: [
        :name,
        :ability,
        :proficiency,
        :item,
        :armor,
        :notes
      ],
      pathfinder_melee_strikes_attributes: [
        :weapon,
        :weapon_strength,
        :proficiency,
        :item,
        :dice,
        :types,
        :damage_strength,
        :weapon_specialization,
        :traits,
        :other
      ],
      pathfinder_ranged_strikes_attributes: [
        :weapon,
        :weapon_dexterity,
        :proficiency,
        :item,
        :dice,
        :types,
        :special,
        :weapon_specialization,
        :range,
        :traits,
        :other,
        :notes
      ],
      pathfinder_languages_attributes: [
        :name,
        :notes
      ],
      pathfinder_weapon_profics_attributes: [
        :name,
        :proficiency
      ],
      pathfinder_feats_attributes: [
        :level,
        :name,
        :notes
      ],
      pathfinder_inventories_attributes: [
        :name,
        :amount,
        :bulk,
        :notes
      ],
      pathfinder_money_attributes: [
        :pp,
        :gp,
        :sp,
        :cp
      ]
    )
  end
end