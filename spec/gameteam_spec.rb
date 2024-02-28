require 'spec_helper'

RSpec.describe GameTeam do

  before(:each) do
    attrs = { game_id: 2_012_030_221,
    team_id: 3,
    hoa: "away",
    result: "LOSS",
    settled_in: "OT",
    head_coach: 'John Tortorella',
    goals: 2,
    shots: 8,
    tackles: 44,
    pim: 8,
    powerPlayOpportunities: 3,
    powerPlayGoals: 0,
    faceOffWinPercentage: 44.8,
    giveaways: 17,
    takeaways: 7 }
    @game_team = GameTeam.new(attrs)
  end

  it 'exists and has attributes' do
    expect(@game_team).to be_a(GameTeam)
    expect(@game_team.game_id).to eq(2_012_030_221)
    expect(@game_team.team_id).to eq(3)
    expect(@game_team.hoa).to eq("away")
    expect(@game_team.result).to eq("LOSS")
    expect(@game_team.settled_in).to eq("OT")
    expect(@game_team.head_coach).to eq('John Tortorella')
    expect(@game_team.goals).to eq(2)
    expect(@game_team.shots).to eq(8)
    expect(@game_team.tackles).to eq(44)
    expect(@game_team.pim).to eq(8)
    expect(@game_team.powerPlayOpportunities).to eq(3)
    expect(@game_team.powerPlayGoals).to eq(0)
    expect(@game_team.faceOffWinPercentage).to eq(44.8)
    expect(@game_team.giveaways).to eq(17)
    expect(@game_team.takeaways).to eq(7)
  end

  it "can create a GameTeam from CSV" do
    new_game_teams = GameTeam.create_from_csv("./data/game_teams.csv")
    expect(new_game_teams).to eq([])
  end
end
