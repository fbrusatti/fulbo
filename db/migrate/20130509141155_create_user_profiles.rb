class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.references :user
      t.string :name
      t.string :surname
      t.string :nickname
      t.string :playing_position
      t.string :born
      t.string :locality
      t.string :foot
      t.string :features

      t.timestamps
    end
  end
end
