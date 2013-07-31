# == Schema Information
#
# Table name: fields
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  type        :string(255)
#  category    :string(255)
#  price       :decimal(8, 2)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Field < ActiveRecord::Base
  serialize :description, Array

  # == Accessors
  attr_accessible :category, :description, :name, :price, :surface

  # == Validations
  validates_presence_of :name,:category,:surface

   # == Associations
  belongs_to :location
  has_many :reservations

  def complete_name
  	name + " (#{location.sport_center.name} , #{location.name})" 
  end	
end
