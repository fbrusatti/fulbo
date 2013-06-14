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
  has_many :team_users,  dependent: :destroy
  has_many :players, through: :team_users
  has_many :affiliations, dependent: :destroy
  has_many :leagues, through: :affiliations

  # == Callbacks
  before_create :init_profile

  # == Accessors
  attr_accessible :captain, :name, :profile_attributes, :team_users_attributes

  # == Nested Attributes
  accepts_nested_attributes_for :profile  
  accepts_nested_attributes_for :team_users , :allow_destroy => true, 
                                :reject_if => :all_blank
  
  # == FriendlyId
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  # == Scope
  scope :out_of_team, lambda { |team| where(User.all - :team.users, :tema=> team)}

  private
    def init_profile
      build_profile if profile.blank?
    end

end