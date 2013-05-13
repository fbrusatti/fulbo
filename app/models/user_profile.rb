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

  
  attr_accessible :user_id, :name, :surname, :nickname, :playing_position, :born, 
  :locality, :foot, :avatar, :features

  belongs_to :user 
  validates_presence_of :name, :surname, :playing_position
  validates :features, length: {maximum: 200}

  values = %w(Goalkeeper Defender Midfielder Forward Coach Coaching staff Referee Assistant referee)
  validates :playing_position, :inclusion => { :in => values }

end
