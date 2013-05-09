# == Schema Information
#
# Table name: user_profiles
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserProfile < ActiveRecord::Base
  attr_accessible :user_id
  belongs_to :user 
end
