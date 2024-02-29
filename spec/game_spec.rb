require 'spec_helper'

RSpec.describe Game do

  before(:each) do
    game_data = {
      game_id: 2012030221,
      season: 20122013,
      type: "Postseason",
      away_team_id: 3,
      home_team_id: 6,
      away_goals: 2,
      home_goals: 3
    }
    @game1 = Game.new(game_data)

    @games = Game.create_from_csv("./data/games_dummy.csv")
  end

  it 'exists' do
    expect(@game1).to be_an_instance_of Game
  end
      
  it 'has attributes that can be read' do
    expect(@game1.game_id).to eq 2012030221
    expect(@game1.season).to eq 20122013
    expect(@game1.type).to eq "Postseason"
    expect(@game1.away_team_id).to eq 3
    expect(@game1.home_team_id).to eq 6
    expect(@game1.away_goals).to eq 2
    expect(@game1.home_goals).to eq 3
  end

  it "can create Game objects using the create_from_csv method" do
    test_game = @games.first
    expect(test_game.game_id).to eq 2012030221
    expect(test_game.season).to eq 20122013
    expect(test_game.type).to eq "Postseason"
    expect(test_game.away_team_id).to eq 3
    expect(test_game.home_team_id).to eq 6
    expect(test_game.away_goals).to eq 2
    expect(test_game.home_goals).to eq 3
  end

  it 'can return all of the seasons in an array' do
    expected = [20122013,20132014,20142015,20152016,20162017,20172018]
    expect(Game.all_seasons).to eq (expected)
  end

  it 'can return a count of games by season' do
    #Going to need to create hashes with the season id as the key 
    #and the number (int) of games as the value
    # expect(Game.count_of_games_by_season).to be a Hash
    # expect(Game.count_of_games_by_season[:20122013]).to eq 9
  end

end