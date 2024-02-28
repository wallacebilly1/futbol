require 'CSV'

class Game

    attr_reader :game_id, :season, :away_team_id, :home_team_id, :away_goals, :home_goals, :venue
    def initialize(game_id, season, away_team_id, home_team_id, away_goals, home_goals, venue)
        @game_id = game_id
        @season = season #formatted_season(season)
        @away_team_id = away_team_id.to_i
        @home_team_id = home_team_id.to_i
        @away_goals = away_goals.to_i
        @home_goals = home_goals.to_i
        @venue = venue
    end

    def self.create_from_csv(file_path)
        CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
            game_id = row[:game_id]
            season = row[:season]
            away_team_id = row[:away_team_id]
            home_team_id = row[:home_team_id]
            away_goals = row[:away_goals]
            home_goals = row[:home_goals]
            venue = row[:venue]

            p Game.new(game_id, season, away_team_id, home_team_id, away_goals, home_goals, venue)
        end
    end

    # def formatted_season(season)
    #     formatted_season = {
    #         start: season[0..3],
    #         end: season[4..7]
    #     }
        
    #     formatted_season
    # end

    # def search_for_team_name(id)
    # end

end