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
  attr_accessible :category, :description, :name, :price, :type

  # == Validations
  validates_presence_of :name,:category,:type

   # == Associations
  belongs_to :location
end
