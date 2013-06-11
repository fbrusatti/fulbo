namespace :db do
  desc "ensure that all teams have a profile"
  task :profile => :environment do
    User.all.each do |user|
      user.team.create_profile if user.team && user.team.profile.nil?
    end
  end
end
