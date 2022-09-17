module EditCharactersHelper
  def proficiencies
    [
      ["Untrained", 0],
      ["Trained", 2],
      ["Expert", 4],
      ["Master", 6],
      ["Legendary", 8]
    ]
  end

  def abilities
    [
      ["Strength", "str"],
      ["Dexterity", "dex"],
      ["Constitution", "con"],
      ["Intelligence", "int"],
      ["Wisdom", "wis"],
      ["Charisma", "cha"]
    ]
  end

  def alignment
    [
      "Lawful Good",
      "Lawful Neutral",
      "Lawful Evil",
      "Neutral Good",
      "True Neutral",
      "Neutral Evil",
      "Chaotic Good",
      "Chaotic Neutral",
      "Chaotic Evil"
    ]
  end

  def types_feats
    [
      "Ancestry",
      "Class",
      "Skill",
      "General",
      "Bonus"
    ]
  end

  def types_weapon
    [
      "Bludgeoning",
      "Piercing",
      "Slashing"
    ]
  end

  def dice
    [
      "d4",
      "d6",
      "d8",
      "d10",
      "d12",
      "d20",
      "d100"
    ]

  end

  def magic_tradition
    [
      "Arcane",
      "Prismal",
      "Occult",
      "Divine"
    ]
  end

  def spellcasting_type
    [
      "Prepared",
      "Spontaneous"
    ]
  end

  def spell_component
    [
      "Material",
      "Somatic",
      "Verbal"
    ]
  end

  def actions
    [
      "1",
      "2",
      "3",
      "4",
      "5"
    ]
  end

end
