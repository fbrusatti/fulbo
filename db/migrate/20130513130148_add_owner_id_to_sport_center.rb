class AddOwnerIdToSportCenter < ActiveRecord::Migration
  def change
    add_column :sport_centers, :owner_id, :integer
  end
end
