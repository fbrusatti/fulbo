class AddSlugToUsers < ActiveRecord::Migration
  def change
    add_column :user_profiles, :slug, :string
    add_index :user_profiles, :slug
  end
end
