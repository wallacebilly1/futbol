require 'spec_helper'

RSpec.describe GameTeam do

  before(:each) do
    attrs = { game_id: 2_012_030_221,
    team_id: 3,
    HoA: away,
    result: LOSS,
    settled_in: OT,
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
    expect(game_id).to eq(2_012_030_221)
    expect(team_id).to eq(3)
    expect(HoA).to eq(away)
    expect(result).to eq(LOSS)
    expect(settled_in).to eq(OT)
    expect(head_coach).to eq('John Tortorella')
    expect(goals).to eq(2)
    expect(shots).to eq(8)
    expect(tackles).to eq(44)
    expect(pim).to eq(8)
    expect(powerPlayOpportunities).to eq(3)
    expect(powerPlayGoals).to eq(0)
    expect(faceOffWinPercentage).to eq(44.8)
    expect(giveaways).to eq(17)
    expect(takeaways).to eq(7)
  end
end
