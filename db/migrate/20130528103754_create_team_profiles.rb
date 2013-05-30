class CreateTeamProfiles < ActiveRecord::Migration
  def change
    create_table :team_profiles do |t|
      t.references :team
      t.string :category
      t.string :surface
      t.string :geo_availability
      t.string :badge
      t.string :description

      t.timestamps
    end
  end
end
