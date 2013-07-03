namespace :resize do
  desc "resize avatar profile images"
  task :avatar_profile => :environment do
    UserProfile.all.each do |up|
      up.avatar.recreate_versions! if up.avatar?
    end
  end
end
