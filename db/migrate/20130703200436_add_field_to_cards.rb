class AddFieldToCards < ActiveRecord::Migration
  def change
    add_column :cards, :time, :integer
    add_column :cards, :type, :string
    add_column :cards, :description, :string
  end
end
