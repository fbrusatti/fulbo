class Goal < ActiveRecord::Base

  # == Associations
  belongs_to :match
  belongs_to :team_user

  attr_accessible :time, :description, :count, :team_user_id

  # accepts_nested_attributes_for :goals, :reject_if => :all_blank, :allow_destroy => true
end
