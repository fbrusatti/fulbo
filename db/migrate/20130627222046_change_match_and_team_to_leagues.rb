class ChangeMatchAndTeamToLeagues < ActiveRecord::Migration
  def up
    execute 'ALTER TABLE leagues ALTER COLUMN number_teams TYPE integer USING CAST(number_teams AS INTEGER)'
    execute 'ALTER TABLE leagues ALTER COLUMN number_matches TYPE integer USING CAST(number_matches AS INTEGER)'
  end

  def down
    execute 'ALTER TABLE leagues ALTER COLUMN number_teams TYPE varchar USING CAST(number_teams AS VARCHAR)'
    execute 'ALTER TABLE leagues ALTER COLUMN number_matches TYPE varchar USING CAST(number_matches AS VARCHAR)'
  end
end
