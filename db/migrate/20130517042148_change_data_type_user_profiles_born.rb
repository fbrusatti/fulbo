class ChangeDataTypeUserProfilesBorn < ActiveRecord::Migration
  def up
     execute "ALTER TABLE user_profiles ALTER COLUMN born TYPE DATE 
              using to_date(born, 'YYYY-MM-DD');"
  end

end
