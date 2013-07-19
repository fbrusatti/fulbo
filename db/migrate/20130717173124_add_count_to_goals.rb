class AddCountToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :count, :integer
  end
end
