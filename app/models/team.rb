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

  # == Scope
  scope :out_of_league, lambda {|league|
    where(['id NOT IN
      (SELECT affiliations.team_id FROM affiliations WHERE affiliations.league_id = ?)', league.id])
  }

  # == Validations
  validates_presence_of :name

  # == Associations
  belongs_to :owner, class_name: "User"

  has_one :profile, dependent: :destroy,
                  class_name: "TeamProfile",
                  inverse_of: :team
  has_many :photos
  has_many :team_users
  has_many :players, through: :team_users
  has_many :affiliations, dependent: :destroy
  has_many :leagues, through: :affiliations
  has_many :visitor_matches, class_name: "Match", foreign_key: "visitor_id"
  has_many :local_matches, class_name: "Match", foreign_key: "local_id"
  # they are requests that I'm sending
  has_many :inscription_requesters,
           class_name: 'RequestInscription',
           as: :requester
  # they are requests that I'm receiving
  has_many :inscription_requests,
           class_name: 'RequestInscription',
           as: :requested


  # == Callbacks
  before_create :init_profile

  # == Accessors
  attr_accessible :captain, :name, :profile_attributes, :player_tokens, :players

  # == attr reader
  attr_reader :player_tokens

  # == Nested Attributes
  accepts_nested_attributes_for :profile
  accepts_nested_attributes_for :players

  # == FriendlyId
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  def player_tokens=(ids)
      self.player_ids = ids.split(",")
  end
  private
    def init_profile
      build_profile if profile.blank?
    end
end
