class PointSystem < ActiveRecord::Base

  # == Accessors
  attr_accessible :win, :tie, :loser

  # == Validations
  validates_presence_of :win, :tie, :loser

  # == Associations
  belongs_to :league

end

