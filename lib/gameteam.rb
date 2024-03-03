require 'CSV'

class GameTeam
  @@all = []
  attr_reader :game_id,
              :team_id,
              :hoa,
              :result,
              :head_coach,
              :goals,
              :shots,
              :tackles

  def initialize(gameteam_data)
    @game_id = gameteam_data[:game_id].to_s
    @team_id = gameteam_data[:team_id].to_s
    @hoa = gameteam_data[:hoa]
    @result = gameteam_data[:result]
    @head_coach = gameteam_data[:head_coach]
    @goals = gameteam_data[:goals]
    @shots = gameteam_data[:shots]
    @tackles = gameteam_data[:tackles]
  end

  def self.create_from_csv(game_teams_path)
    CSV.foreach(game_teams_path, headers: true, converters: :all) do |row|
      gameteam_data = { 
        game_id: row["game_id"],
        team_id: row["team_id"],
        hoa: row["HoA"],
        result: row["result"],
        settled_in: row["settled_in"],
        head_coach: row["head_coach"],
        goals: row["goals"],
        shots: row["shots"],
        tackles: row["tackles"]
      }
    @@all << GameTeam.new(gameteam_data)
    end
    @@all
  end

  def self.tackles_per_team(season_id)
    tackles_per_team = Hash.new(0)

    @@all.each do |row|
      if season_id[0..3] == row.game_id[0..3]
        tackles_per_team[row.team_id] += row.tackles
      end
    end
    tackles_per_team
  end

  def self.fewest_tackles(tackles_per_team_hash)
    tackles_per_team_hash.min_by {|team_id, tackles| tackles}.first
  end

  def self.fewest_tackles_by_season(season_id)
    tackles_per_team_hash = GameTeam.tackles_per_team(season_id)
    GameTeam.fewest_tackles(tackles_per_team_hash)
  end

  def self.winningest_coach(season_id)
    games_by_coach = Hash.new(0)
    wins_by_coach = Hash.new(0)

    @@all.each do |row|
      if season_id[0..3] == row.game_id[0..3]
        games_by_coach[row.head_coach] += 1
      end

      if row.result == "WIN" && season_id[0..3] == row.game_id[0..3]
        wins_by_coach[row.head_coach] += 1
      end
    end

    win_percent_by_coach = Hash.new

    games_by_coach.each do |key, value|
      if wins_by_coach[key].nil? || wins_by_coach[key] == 0
        win_percent_by_coach[key] = nil
      else
        win_percent_by_coach[key] = wins_by_coach[key] / value.to_f
      end
      win_percent_by_coach
    end
    win_percent_by_coach.compact.max_by do |key, value|
      value
    end.first
  end
end