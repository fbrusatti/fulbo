# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  captain    :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Team < ActiveRecord::Base

  # == Validations
  validates_presence_of :name

  # == Associations
  belongs_to :owner,
             class_name: "User",
             foreign_key: "user_id"

  has_many :team_users
  has_many :users, through: :team_users

  # == Accessors
  attr_accessible :captain, :name
end
