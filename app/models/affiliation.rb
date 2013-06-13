class Affiliation < ActiveRecord::Base

  # == Associations
  belongs_to :league
  belongs_to :team
end
