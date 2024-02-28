require './spec/spec_helper'

RSpec.describe Team do

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

end