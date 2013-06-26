class Week < ActiveRecord::Base

  attr_accessible :number, :start_date, :end_date

  # == Associations
  belongs_to :fixture
  has_many :matches

  # == Validations
  validates_presence_of :number
end
