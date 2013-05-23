class CreateTeamUsers < ActiveRecord::Migration
  def change
    create_table :team_users do |t|
      t.references :team
      t.references :user
      t.timestamps
    end

    add_index :team_users, :team_id
    add_index :team_users, :user_id
    add_index :team_users, [:team_id, :user_id], unique: true
  end
end
