class Reservation < ActiveRecord::Base

  # == Associations
  belongs_to :match
  belongs_to :field

  # == Accessors
  attr_accessible :reservation_date

  # == Validations
  validates_presence_of :reservation_date
end
