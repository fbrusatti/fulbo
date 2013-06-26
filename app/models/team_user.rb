# == Schema Information
#
# Table name: team_users
#
#  id         :integer          not null, primary key
#  team_id    :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TeamUser < ActiveRecord::Base

  # == Associations
  belongs_to :team
  belongs_to :player, foreign_key: "user_id", class_name: "User"
  belongs_to :user
  has_many :goals
  has_many :cards
end
