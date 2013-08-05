namespace :resize do
  desc "resize avatar profile images"
  task :avatar_profile => :environment do
    UserProfile.all.each do |up|
      up.avatar.recreate_versions! if up.avatar?
    end
  end

  desc "generate thumbnail badge image"
  task :thumbnail_badge => :environment do
    TeamProfile.all.each do |up|
      up.badge.recreate_versions! if up.badge?
    end
  end
end
