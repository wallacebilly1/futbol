require './spec/spec_helper'

RSpec.describe StatTracker do

  before(:all) do
    games_file = './data/games.csv'
    teams_file = './data/teams.csv'
    game_teams_file = './data/game_teams_dummy.csv'

    locations = {
      games: games_file,
      teams: teams_file,
      game_teams: game_teams_file
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  it 'exists' do
    expect(@stat_tracker).to be_a StatTracker
  end

  it 'initializes data from a CSV file' do
    expect(@stat_tracker.games.first).to be_a Game
    expect(@stat_tracker.teams.first).to be_a Team
    expect(@stat_tracker.game_teams.first).to be_a GameTeam
  end

  it '#percentage_home_wins' do
    percentage_home_wins = @stat_tracker.percentage_home_wins
    expect(percentage_home_wins).to be_a Float
    expect(percentage_home_wins).to eq 0.44
  end

  it '#percentage_visitor_wins' do
    percentage_visitor_wins = @stat_tracker.percentage_visitor_wins
    expect(percentage_visitor_wins).to be_a Float
    expect(percentage_visitor_wins).to eq 0.36
  end

  it '#percentage_ties' do
    percentage_ties = @stat_tracker.percentage_ties
    expect(percentage_ties).to be_a Float
    expect(percentage_ties).to eq 0.2
  end

  it '#count_of_games_by_season' do
    games_by_season = @stat_tracker.count_of_games_by_season
    expect(games_by_season).to be_a Hash
    expect(games_by_season.count).to eq 6
  end

  it '#average_goals_by_season' do
    goals_by_season = @stat_tracker.average_goals_by_season
    expect(goals_by_season).to be_a Hash
    expect(goals_by_season.count).to eq 6
  end

  it '#highest_scoring_visitor' do
    expect(@stat_tracker.highest_scoring_visitor).to be_a String
    expect(@stat_tracker.highest_scoring_visitor).to eq ("FC Dallas")
  end

  it '#lowest_scoring_visitor' do
    expect(@stat_tracker.lowest_scoring_visitor).to be_a String
    expect(@stat_tracker.lowest_scoring_visitor).to eq ("San Jose Earthquakes")
  end

  it '#fewest_tackles' do
    expect(@stat_tracker.fewest_tackles("20122013")).to eq "Sporting Kansas City"
    expect(@stat_tracker.fewest_tackles("20132014")).to eq "New England Revolution"
  end

end
