class MoveNameToUsers < ActiveRecord::Migration
  def up
    remove_column :user_profiles, :name
    add_column :users, :name, :string
  end

  def down
    add_column :user_profiles, :name, :string
    remove_column :users, :name
  end
end
