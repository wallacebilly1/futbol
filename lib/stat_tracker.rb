class StatTracker
  attr_reader :games, :teams, :game_teams
  
  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end
  
  def self.from_csv(locations)
    games = Game.create_from_csv(locations[:games])
    teams = Team.create_from_csv(locations[:teams])
    game_teams = GameTeam.create_from_csv(locations[:game_teams])
    StatTracker.new(games, teams, game_teams)
  end

  def percentage_home_wins
    home_win_counter = 0
    self.games.each do |game|
      if game.home_goals > game.away_goals
        home_win_counter += 1
      end
    end
    (home_win_counter / self.games.length.to_f).round(2) # 3237 / 7441
  end

  def percentage_visitor_wins
    visitor_win_counter = 0
    self.games.each do |game|
      if game.away_goals > game.home_goals
        visitor_win_counter += 1
      end
    end
    (visitor_win_counter / self.games.length.to_f).round(2) # 2687 / 7441
  end

  def percentage_ties
    tie_counter = 0
    self.games.each do |game|
      if game.away_goals == game.home_goals
        tie_counter += 1
      end
    end
    (tie_counter / self.games.length.to_f).round(2) # 1517 / 7441
  end

  def highest_scoring_visitor
    visiting_team = String.new
    games_played = 0
    score_counter = 0
    score_pg = 0

    self.teams.each do |team|
      self.games.each do |game|
        if team.id == game.away_team_id
          games_played += 1
          score_counter += game.away_goals
        end
      end

      avg_score_pg = (score_counter / games_played.to_f).round(4)

      if avg_score_pg > score_pg
        visiting_team = team.name
        score_pg = avg_score_pg
      end

      games_played = 0
      score_counter = 0      
    end

    p visiting_team
  end

  def lowest_scoring_visitor
    visiting_team = String.new
    games_played = 0
    score_counter = 0
    score_pg = 0

    self.teams.each do |team|
      self.games.each do |game|
        if team.id == game.away_team_id
          games_played += 1
          score_counter += game.away_goals
        end
      end

      avg_score_pg = (score_counter / games_played.to_f).round(4)

      if avg_score_pg <= score_pg
        visiting_team = team.name
        score_pg = avg_score_pg
      end

      games_played = 0
      score_counter = 0      
    end

    p visiting_team
  end


end