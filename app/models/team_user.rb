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
  belongs_to :player, class_name: "User"

end
