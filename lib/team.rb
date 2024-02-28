require 'CSV'

class Team

    attr_reader :id, :name
    def initialize(id, name)
        @id = id.to_i
        @name = name
    end

    def self.create_from_csv(file_path)
        all_teams = []

        CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
            id = row[:team_id]
            name = row[:teamname]

            all_teams << Team.new(id, name)
        end

        # Iterating over each team to check the values
        # all_teams.each do |team|
        #     p team
        # end

        #all_teams
    end

end 