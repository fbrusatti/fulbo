class SportCenter < ActiveRecord::Base
  attr_accessible :address, :cuit, :description, :email, :name, :phone
  before_save { |sport_center| sport_center.email = email.downcase }
  before_save { |sport_center| sport_center.description = description.downcase }
  before_save { |sport_center| sport_center.address = address.downcase }
  before_save { |sport_center| sport_center.name = name.downcase }

  validates( :name, presence: true, length: {maximum: 40} )
  validates( :email, presence: true )
  validates( :address, presence: true )
  validates( :description, presence: true, length: {maximum: 100} )
  validates( :phone, presence: true, length: {maximum: 20} )
  validates( :cuit, presence: true )

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/, :on => :create
end
