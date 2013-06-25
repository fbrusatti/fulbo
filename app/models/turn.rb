class Turn < ActiveRecord::Base

  # == Associations
  belongs_to :match
  belongs_to :field

  # == Accessors
  attr_accessible :date

  # == Validations
  validates_presence_of :date
end
