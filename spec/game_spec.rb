require './spec/spec_helper'

RSpec.describe Game do

    it 'exists' do
        new_game = Game.new(2012030221, 20122013, 3, 6, 2, 3, "Toyota Stadium")
        expect(new_game).to be_an_instance_of Game
    end
    
    it 'has attributes' do
        new_game = Game.new(2012030221, 20122013, 3, 6, 2, 3, "Toyota Stadium")
        
        expect(new_game.game_id).to eq 2012030221
        expect(new_game.season).to eq 20122013
        expect(new_game.away_team_id).to eq 3
        expect(new_game.home_team_id).to eq 6
        expect(new_game.away_goals).to eq 2
        expect(new_game.home_goals).to eq 3        
        expect(new_game.venue).to eq "Toyota Stadium"
    end
      
end