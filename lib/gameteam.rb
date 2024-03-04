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

  def all
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

  def self.worst_coach(season_id)
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
      if wins_by_coach[key].nil? 
        win_percent_by_coach[key] = nil
      else
        win_percent_by_coach[key] = wins_by_coach[key] / value.to_f
      end
      win_percent_by_coach
    end

    win_percent_by_coach.compact.min_by do |key, value|
      value
    end.first
  end
  
  def self.avg_scores_per_team_home
    team_scores = Hash.new(0)
    gameteam_counter = Hash.new(0)
    @@all.each do |gameteam|
      if gameteam.hoa == "home"
        team_scores[gameteam.team_id] += gameteam.goals
        gameteam_counter[gameteam.team_id] += 1
      end
    end
    array_of_scores_to_games = []
    result_hash = {}
    team_scores.values.each_with_index do |value, index|
      array_of_scores_to_games << (value.to_f / gameteam_counter.values[index]).round(2)
    end
    result_hash = team_scores.keys.zip(array_of_scores_to_games).to_h
  end

  def self.pulls_team_id_max_score_home
    avg_scores_per_team_home.max_by {|team_id, goals| goals}.first
  end
  
  def self.pulls_team_id_min_score_home
    avg_scores_per_team_home.min_by {|team_id, goals| goals}.first
  end

  def self.pull_id_goals_shots_and_math(season_id)
    id_and_goals = Hash.new(0)
    id_and_shots = Hash.new(0)
    
    @@all.each do |row|
      if row.game_id[0..3] == season_id[0..3]
        id_and_shots[row.team_id] += row.shots
      end
    end
    @@all.each do |row|
      if row.game_id[0..3] == season_id[0..3]
        id_and_goals[row.team_id] += row.goals
      end
    end


    array_of_shots_to_goals = []
    result_hash = {}

    id_and_shots.values.each_with_index do |value, index|
      array_of_shots_to_goals << (value.to_f / (id_and_goals.values[index]))
    end

    result_hash = id_and_shots.keys.zip(array_of_shots_to_goals).to_h
  end

  def self.most_accurate_team(season_id)
    pull_id_goals_shots_and_math(season_id).min_by {|team_id, shotsngoals| shotsngoals}.first
  end

  def self.least_accurate_team(season_id)
    pull_id_goals_shots_and_math(season_id).max_by {|team_id, shotsngoals| shotsngoals}.first
  end

  # def self.best_offense
  # @@game_teams.first.goals
  # require 'pry'; binding.pry
  # team_stat = {}
  # start with an array of game teams and for each game team,
  # @@game_teams.each do |gameteam|
  
  # if team_id key doesn't exist,
  # add team_id as a key and its value will be the goals and games hash.
  # team_stat[3] = {goals: (gameteam.goals), games: 1}
  # else if team_id does exist
  # add together goals and add 1 to games
  #
  # divide goals scored by number of games played for each team
  # return team id(/name) with highest average score
  # end
  
  
  
  
  # def self.worst_offense
  #   Name of the team with the lowest average number of goals scored per game across all seasons.
  # end
  
end
