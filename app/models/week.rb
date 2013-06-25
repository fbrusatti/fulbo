class Week < ActiveRecord::Base

  attr_accessible :number, :date

  # == Associations
  belongs_to :fixture
  has_many :matches
end
