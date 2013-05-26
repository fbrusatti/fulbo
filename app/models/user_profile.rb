# == Schema Information
#
# Table name: user_profiles
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  surname          :string(255)
#  nickname         :string(255)
#  playing_position :string(255)
#  locality         :string(255)
#  foot             :string(255)
#  features         :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  avatar           :string(255)
#  dob              :date
#

class UserProfile < ActiveRecord::Base
  # == Delegation
  delegate :name, :to => :user, :allow_nil => true
  delegate :name=, :to => :user, :allow_nil => true

  # == Callbacks
  after_destroy :remove_tmp_directory
  after_update :crop_avatar
  after_save :save_name

  serialize :playing_position, Array

  # == Accessors
  attr_accessible :user_id, :name, :surname, :nickname, :playing_position, :dob,
                  :locality, :foot, :features, :avatar, :avatar_cache, :remove_avatar,
                  :remote_avatar_url, :crop_x, :crop_y, :crop_w, :crop_h
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  # == Associations
  belongs_to :user, inverse_of: :profile

  # == Mount
  mount_uploader :avatar, AvatarUploader

  # == Validations
  # validates_presence_of :name, :surname, :playing_position
  validates :features, length: {maximum: 200}

  # == Instance Methods
  def crop_avatar
    avatar.recreate_versions! if crop_x.present?
  end

  private
    # For removing temp folder of avatar after destroy picture
    def remove_tmp_directory
      path_to_be_deleted = "#{Rails.root}/public/uploads/tmp"
      FileUtils.remove_dir(path_to_be_deleted, :force => true)
    end

    def save_name
      user.name = name
      user.save
    end
end
