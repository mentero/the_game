class TheGame
  class Person
    class LookForPlaceToSleep
      def description
        "going near fireplace to sleep"
      end

      def perform(person, map, time_in_minutes)
        fire_tile = TheGame::Settlement.instance.fire_tile

        if person.distance_to(fire_tile) < 3.0
          # assume that person needs a safe place to sleep
          # for now, the only option is the fireplace

          person.action = Sleep.new
        else
          person.go_to(fire_tile)
        end
      end

      private
    end
  end
end
