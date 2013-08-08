# == Schema Information
#
# Table name: team_profiles
#
#  id               :integer          not null, primary key
#  team_id          :integer
#  category         :string(255)
#  surface          :string(255)
#  geo_availability :string(255)
#  badge            :string(255)
#  description      :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class TeamProfile < ActiveRecord::Base

  # == Accessors
  attr_accessible :category, :surface, :description, :geo_availability, :badge,
                  :remove_badge, :badge_cache, :remote_badge_url
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  # == Associations
  belongs_to :team, inverse_of: :profile

  # == Mount
  mount_uploader :badge, AvatarUploader

  # == Serializes
  serialize :category, Array
  serialize :surface, Array

  validates :description, length: {maximum: 200}

  include PgSearch
  pg_search_scope :search, against: [:category, :surface],
                  using: {:tsearch => {:prefix => true}},
                  associated_against: {:team => :name}

  def self.search_teams(query)
    if query.present?
      search(query)
    else
      scoped
    end
  end

end
