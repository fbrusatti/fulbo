class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.references :match
      t.references :team_user
      t.timestamps
    end

    add_index :goals, :match_id
    add_index :goals, :team_user_id
  end
end
