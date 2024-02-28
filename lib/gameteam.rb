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

end
