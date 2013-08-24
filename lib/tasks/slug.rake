namespace :slug do
  desc "Generate slug to Sport Centers"
  task :to_sport_centers => :environment do
    SportCenter.find_each(&:save)
  end

  desc "Generate slug to Leagues"
  task :to_leagues => :environment do
    League.find_each(&:save)
  end
end
