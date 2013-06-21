class Affiliation < ActiveRecord::Base
  attr_accessible :team_id

  # == Associations
  belongs_to :league
  belongs_to :team
end
