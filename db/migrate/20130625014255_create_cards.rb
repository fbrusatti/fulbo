class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.references :match
      t.references :team_user
      t.timestamps
    end

    add_index :cards, :match_id
    add_index :cards, :team_user_id
  end
end
