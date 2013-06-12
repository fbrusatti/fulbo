class CreateAffiliations < ActiveRecord::Migration
  def change
    create_table :affiliations do |t|
      t.references :league
      t.references :team
      t.timestamps
    end

    add_index :affiliations, :league_id
    add_index :affiliations, :team_id
    add_index :affiliations, [:league_id, :team_id], unique: true
  end
end
