class CreateJoinTableLeagueTeam < ActiveRecord::Migration
  def change
    create_table :leagues_teams, id: false do |t|
      t.integer :league_id
      t.integer :team_id
    end

    add_index :leagues_teams, [:team_id, :league_id]
    add_index :leagues_teams, [:league_id, :team_id]
  end
end
