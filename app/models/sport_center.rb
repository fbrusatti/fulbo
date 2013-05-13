class SportCenter < ActiveRecord::Base
  attr_accessible :address, :cuit, :description, :email, :name, :phone , :owner_id
  belongs_to :owner, :class_name => 'User', :foreign_key => 'owner_id' , :validate => true 	

  validates_presence_of :address, :cuit, :description, :email, :name, :phone
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/
  validates :name, length: {maximum: 40}
  validates :description, length: {maximum: 100}
  validates :phone, length: {maximum: 20}
end
