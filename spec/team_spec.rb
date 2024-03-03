require 'spec_helper'

RSpec.describe Team do
  before(:all) do  
    @teams = Team.create_from_csv("./data/teams.csv")
  end
      
  before(:each) do
    team_data = {
      id: 1,
      name: "Atlanta United"
    }
    @team1 = Team.new(team_data)
  end  

  it 'exists' do
    expect(@team1).to be_an_instance_of Team
  end

  it 'has attributes that can be read' do
    expect(@team1.id).to eq 1
    expect(@team1.name).to eq "Atlanta United"
  end

  it "can create Team objects using the create_from_csv method" do
    new_team = Team.create_from_csv("./data/teams.csv")
    starter = new_team.first
    expect(starter.id).to eq 1
    expect(starter.name).to eq "Atlanta United"
  end

  it '#highest_scoring_visitor outputs correctly' do
    expect(Team.highest_scoring_visitor).to eq "FC Dallas"
  end

  it '#lowest_scoring_visitor outputs correctly' do
    expect(Team.lowest_scoring_visitor).to eq "San Jose Earthquakes"
  end

  it '#generate_score_data creates correct data' do
    expect(Team.generate_score_data).to be_a Array
    expect(Team.generate_score_data[0]).to be_a Hash
    expect(Team.generate_score_data[0][:team_id]).to be_a Integer
    expect(Team.generate_score_data[0][:team_name]).to be_a String
    expect(Team.generate_score_data[0][:team_games_played]).to be_a Integer
    expect(Team.generate_score_data[0][:team_score_counter]).to be_a Integer
    expect(Team.generate_score_data[0][:team_average_score_per_game]).to be_a Float
  end

end