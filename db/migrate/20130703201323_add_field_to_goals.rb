class AddFieldToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :time, :integer
    add_column :goals, :description, :string
  end
end
