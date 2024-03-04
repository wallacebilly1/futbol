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

  def self.best_offense
    team_id_hash = @@all.group_by { |games| games.team_id }
    team_id_hash.each do |teamid, games|
      sum = games.sum { |games| games.goals }
      count = games.count
      team_id_hash[teamid] = (sum / count.to_f).round(2)
    end
    bestid = team_id_hash.max_by { |_, average| average }.first
    teams = Team.create_from_csv('./data/teams.csv')
    best_offense = teams.find { |team| team.id == bestid }.name
  end




  # def self.worst_offense
  #   Name of the team with the lowest average number of goals scored per game across all seasons.
  # end

end
