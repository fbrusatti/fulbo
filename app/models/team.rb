# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  captain    :integer
#  owner_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string(255)
#

class Team < ActiveRecord::Base

  # == Validations
  validates_presence_of :name

  # == Associations
  belongs_to :owner, class_name: "User"

  has_one :profile, dependent: :destroy,
                  class_name: "TeamProfile",
                  inverse_of: :team
  has_many :photos
  has_many :team_users
  has_many :users, through: :team_users

  # == Callbacks
  before_create :init_profile

  # == Accessors
  attr_accessible :captain, :name, :profile_attributes

  # == Nested Attributes
  accepts_nested_attributes_for :profile

  # == FriendlyId
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  private
    def init_profile
      build_profile if profile.blank?
    end
end