require 'CSV'

class Team
  @@all_teams = []
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
    @@all_teams << Team.new(team_data)  
    end
    @@all_teams
  end

  def self.all_teams
    @@all_teams
  end

  def self.highest_scoring_visitor

  end

  def self.lowest_scoring_visitor

  end

end