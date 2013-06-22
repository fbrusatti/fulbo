class PointSystem < ActiveRecord::Base

  # == Accessors
  attr_accessible :win, :tie, :loose

  # == Validations
  validates_presence_of :win, :tie, :loose

  # == Associations
  belongs_to :league, inverse_of: :point_system

end
