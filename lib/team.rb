require 'CSV'

class Team
  @@all = []
  attr_reader :id, :name

  def initialize(team_data)
    @id = team_data[:id].to_i
    @name = team_data[:name]
  end

  def self.create_from_csv(file_path)
    teams = []
    CSV.foreach(file_path, headers: true, converters: :all) do |row|
      team_data = {
        id: row["team_id"],
        name: row["teamName"]
      }
    @@all << Team.new(team_data)  
    end
    @@all
  end

  def self.all
    @@all
  end

  def self.highest_scoring_visitor
    highest_scoring_visitor = generate_all_team_info.last[:team_name]
  end

  def self.lowest_scoring_visitor
    lowest_scoring_visitor = generate_all_team_info.first[:team_name]
  end

  def self.generate_all_team_info
    all_team_info = Array.new
    @@all.each do |team|
      team_info = {
        team_id: team.id,
        team_name: team.name,
        team_games_played: 0,
        team_score_counter: 0        
      }
      Game.all.each do |game|
        if team.id == game.away_team_id
          team_info[:team_games_played] += 1
          team_info[:team_score_counter] += game.away_goals
        end
      end
      team_info[:aspg] = (team_info[:team_score_counter] / team_info[:team_games_played].to_f).round(8)
      all_team_info << team_info
    end
    sorted_team_info = all_team_info.sort_by do |element|
      element[:aspg]
    end
    sorted_team_info
  end

end


























# def self.highest_scoring_visitor
  #   highest_scoring_visitor = String.new
  #   score_pg = 0
  #   @@all.each do |team|
  #     games_played = 0
  #     score_counter = 0
  #     Game.all.each do |game|
  #       if team.id == game.away_team_id
  #         games_played += 1
  #         score_counter += game.away_goals
  #       end
  #     end
  #     team_avg_score_pg = (score_counter / games_played.to_f).round(4)
  #     if team_avg_score_pg > score_pg
  #       highest_scoring_visitor = team.name
  #       score_pg = team_avg_score_pg
  #     end
  #   end
  #   highest_scoring_visitor
  # end

  # def self.lowest_scoring_visitor
  # end