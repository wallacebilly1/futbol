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
    highest_scoring_visitor = String.new
    games_played = 0
    score_counter = 0
    score_pg = 0

    @@all.each do |team|
      Game.all.each do |game|
        if team.id == game.away_team_id
          games_played += 1
          score_counter += game.away_goals
        end
      end

      avg_score_pg = (score_counter / games_played.to_f).round(4)

      if avg_score_pg > score_pg
        highest_scoring_visitor = team.name
        score_pg = avg_score_pg
      end

      games_played = 0
      score_counter = 0
    end

    highest_scoring_visitor
  end

  # def self.lowest_scoring_visitor

  # end

end