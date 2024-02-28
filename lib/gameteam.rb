require "csv"

class GameTeam
  attr_reader :game_id, :team_id, :hoa, :result, :settled_in, :head_coach, :goals, :shots, :tackles, :pim, :powerPlayOpportunities, :powerPlayGoals, :faceOffWinPercentage, :giveaways, :takeaways

  def initialize(game_team_attrs)
    @game_id = game_team_attrs[:game_id]
    @team_id = game_team_attrs[:team_id]
    @hoa = game_team_attrs[:hoa]
    @result = game_team_attrs[:result]
    @settled_in = game_team_attrs[:settled_in]
    @head_coach = game_team_attrs[:head_coach]
    @goals = game_team_attrs[:goals]
    @shots = game_team_attrs[:shots]
    @tackles = game_team_attrs[:tackles]
    @pim = game_team_attrs[:pim]
    @powerPlayOpportunities = game_team_attrs[:powerPlayOpportunities]
    @powerPlayGoals = game_team_attrs[:powerPlayGoals]
    @faceOffWinPercentage = game_team_attrs[:faceOffWinPercentage]
    @giveaways = game_team_attrs[:giveaways]
    @takeaways = game_team_attrs[:takeaways]
  end

  def self.create_from_csv(game_teams_path)
    game_teams = []
    CSV.foreach(game_teams_path, headers: true, converters: :all) do |row|
      attrs = { game_id: row["game_id"],
    team_id: row["team_id"],
    hoa: row["HoA"],
    result: row["result"],
    settled_in: row["settled_in"],
    head_coach: row["head_coach"],
    goals: row["goals"],
    shots: row["shots"],
    tackles: row["tackles"],
    pim: row["pim"],
    powerPlayOpportunities: row["powerPlayOpportunities"],
    powerPlayGoals: row["powerPlayGoals"],
    faceOffWinPercentage: row["faceOffWinPercentage"],
    giveaways: row["giveaways"],
    takeaways: row["takeaways"] }

    game_teams << GameTeam.new(attrs)
    end
    game_teams
  end

end
