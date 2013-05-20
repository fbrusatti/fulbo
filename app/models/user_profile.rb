# == Schema Information
#
# Table name: user_profiles
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  name             :string(255)
#  surname          :string(255)
#  nickname         :string(255)
#  playing_position :string(255)
#  born             :string(255)
#  locality         :string(255)
#  foot             :string(255)
#  features         :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  avatar           :string(255)
#

class UserProfile < ActiveRecord::Base
  after_destroy :remove_tmp_directory
  serialize :playing_position, Array

  mount_uploader :avatar, AvatarUploader
  after_update :crop_avatar

  attr_accessible :user_id, :name, :surname, :nickname, :playing_position, :born, 
  :locality, :foot, :features, :avatar, :avatar_cache, :remove_avatar, :crop_x, :crop_y, :crop_w, :crop_h

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  belongs_to :user 
  validates_presence_of :name, :surname, :playing_position
  validates :features, length: {maximum: 200}

  def crop_avatar
    avatar.recreate_versions! if crop_x.present?
  end

  private

    # For removing temp folder of avatar after destroy picture
    def remove_tmp_directory
      path_to_be_deleted = "#{Rails.root}/public/uploads/tmp"
      FileUtils.remove_dir(path_to_be_deleted, :force => true)
    end
end
