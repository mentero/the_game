class TheGame
  class Action
    class Sleep < Action
      def initialize(place)
        @place = place
        @minutes_left = 8 * 60
      end

      def description
        "sleeping in #{@place.description}"
      end

      def perform(person, map, time_in_minutes)
        person.energy += @place.energy_per_minute_when_sleeping * time_in_minutes
        @minutes_left -= time_in_minutes
      end

      def done?(person)
        @minutes_left == 0
      end
    end
  end
end
