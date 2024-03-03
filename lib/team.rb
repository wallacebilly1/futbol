require 'CSV'

class Team 
  @@all = []
  attr_reader :id, :name

  def initialize(team_data)
    @id = team_data[:id].to_s
    @name = team_data[:name]
  end

  def self.create_from_csv(file_path)
    CSV.foreach(file_path, headers: true, converters: :all) do |row|
      team_data = {
        id: row["team_id"],
        name: row["teamName"]
      }
    @@all << Team.new(team_data)  
    end
    @@all
  end

  def self.find_team_name_by_id(team_id)
    team_name = String.new
    @@all.each do |team| 
      if team.id == team_id 
        team_name = team.name
      end
    end
    team_name 
  end

  def self.all
    @@all
  end

  def self.highest_scoring_visitor
    generate_score_data.last[:team_name]
  end

  def self.lowest_scoring_visitor
    generate_score_data.first[:team_name]
  end

  def self.generate_score_data

    average_score_teams_list = Array.new
    @@all.each do |team|
      team_info = {
        team_id: team.id,
        team_name: team.name,
        team_games_played: 0,
        team_score_counter: 0,
      }
      Game.all.each do |game|
        if team_info[:team_id].to_i == game.away_team_id
          team_info[:team_games_played] += 1
          team_info[:team_score_counter] += game.away_goals
        end
      end
      team_info[:team_average_score_per_game] = (team_info[:team_score_counter].to_f / team_info[:team_games_played].to_f)
      average_score_teams_list << team_info
    end
    sorted = average_score_teams_list.sort_by do |team|
      team[:team_average_score_per_game]
    end
    sorted
  end

end