class AddUserIdToSportCenter < ActiveRecord::Migration
  def change
    add_column :sport_centers, :user_id, :integer
  end
end
