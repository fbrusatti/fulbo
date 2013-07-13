class SportCenter < ActiveRecord::Base

  # == FriendlyId
  extend FriendlyId
  friendly_id :slug, use: [:slugged, :history]

  # == Validations
  validates_presence_of :address, :cuit, :description, :email, :name, :phone
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/
  validates :name, length: {maximum: 40}
  validates :description, length: {maximum: 100}
  validates :phone, length: {maximum: 20}

  # == Associations
  belongs_to :owner, :class_name => 'User', :validate => true
  has_many :leagues, foreign_key: "organizer_id", dependent: :destroy
  has_many :locations, dependent: :destroy
  has_many :fields, :through => :locations

  # == Accessors
  attr_accessible :address, :cuit, :description,
                  :email, :name, :phone , :owner_id , :slug

end
