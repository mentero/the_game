require_relative "person/eat"
require_relative "person/fetch_food"
require_relative "person/look_for_food"
require_relative "person/look_for_food_to_harvest"
require_relative "person/wonder_for_no_reason"
require_relative "person/harvest"
require_relative "person/carry_food_to_stash"
require_relative "person/review_camp"

class TheGame
  class Person
    include TheGame::HasPosition

    attr_accessor :action, :hunger
    attr_accessor :stash_tile
    attr_reader :inventory

    def initialize(attrs = {})
      @hunger = rand + 0.1

      @action = ReviewCamp.new

      @inventory = Container.new

      self.x = attrs[:x]
      self.y = attrs[:y]
    end

    def is_standing_near_stash?
      close_enough_to(@stash_tile)
    end

    def update(map, time_in_minutes)
      update_hunger(time_in_minutes)
      if should_die?
        die!
      end
      @action.perform(self, map, time_in_minutes)
    end

    def should_die?
      @hunger < 0.01
    end

    def dead?
      @dead == true
    end

    def die!
      @dead = true
    end

    def update_hunger(minutes)
      # assume that:
      # 3 days with no food at all == death from hunger
      # so 0.0002314814814814815 hunger is lost each minute
      # lets call this value
      # 1.5h of eating should provide for ~6h of work, therefore
      # 1minute of eating should replenish for 5alpha

      # also assume 8 hours of sleep and 16 hours of work
      # this all means 6 big meals missed before death
      # so person gets hungry when hunger gets lower than 5/6

      @hunger -= minutes / 4320.0
    end

    def hungry?
      hunger < (5.0/6)
    end

    def to_s
      "P"
    end
  end
end
