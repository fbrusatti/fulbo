class Card < ActiveRecord::Base

  # == Associations
  belongs_to :match
  belongs_to :team_user

  attr_accessible :time, :description, :type
end
