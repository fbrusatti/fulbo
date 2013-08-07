# == Schema Information
#
# Table name: locations
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  address     :string(255)
#  phone       :string(255)
#  locality    :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Location < ActiveRecord::Base
  # == Accessors
  attr_accessible :address, :description, :locality, :name, :phone

  # == Validations
  validates_presence_of :address, :name

  # == Associations
  belongs_to :sport_center
  has_many :fields , dependent: :destroy

  # == Delegators
  delegate :owner, to: :sport_center

  # == Instance Methods
  def reservations
    fields.map(&:reservations).flatten
  end
end
