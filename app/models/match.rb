class Match < ActiveRecord::Base

  # == Associations
  belongs_to :week
  belongs_to :visitor, class_name: "Team"
  belongs_to :local, class_name: "Team"
  has_one :turn
  has_many :cards
  has_many :goals
end
