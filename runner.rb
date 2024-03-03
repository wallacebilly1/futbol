require './spec/spec_helper'
require './lib/stat_tracker'

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)

stat_tracker.highest_scoring_visitor
stat_tracker.lowest_scoring_visitor

p stat_tracker.count_of_teams

# require 'pry'; binding.pry