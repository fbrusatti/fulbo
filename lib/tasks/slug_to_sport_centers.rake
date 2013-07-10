desc "Generate slug to Sport Centers"
task :slug_sport_centers => :environment do
  SportCenter.find_each(&:save)
end
