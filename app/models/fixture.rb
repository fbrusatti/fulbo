class Fixture < ActiveRecord::Base

  # == Associations
  belongs_to :league
  has_many :weeks
end
