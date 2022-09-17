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
end