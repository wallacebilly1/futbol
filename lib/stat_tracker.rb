require './lib/team'
require './lib/gameteam'
require './lib/game'

class StatTracker

    def self.from_csv(locations)
        team_data = Team.create_from_csv(locations[:teams])
        #p GameTeam.create_from_csv(locations[:game_teams])
        game_data = Game.create_from_csv(locations[:games])
    end
    
end