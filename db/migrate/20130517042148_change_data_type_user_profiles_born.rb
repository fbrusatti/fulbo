class ChangeDataTypeUserProfilesBorn < ActiveRecord::Migration
  def up
     # execute "ALTER TABLE user_profiles ALTER COLUMN born TYPE DATE
     #          using to_date(born, 'YYYY-MM-DD');"
    remove_column :user_profiles, :born
    add_column :user_profiles, :dob, :date
  end

end
