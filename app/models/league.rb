class League < ActiveRecord::Base

  # == Accessors
  attr_accessible :name, :category, :number_matches, :field_price, :registration_price,
                  :requirements, :number_teams, :start_date, :point_system_attributes,
                  :affiliations_attributes, :teams_attributes

  # == Validations
  validates_presence_of :name, :category, :start_date

  # == Associations
  belongs_to :organizer, class_name: 'SportCenter'
  has_one :point_system, dependent: :destroy, inverse_of: :league
  has_many :affiliations, dependent: :destroy
  has_many :teams, through: :affiliations

  # == Callbacks
  before_create :init_point_system

  # == Nested Attributes
  accepts_nested_attributes_for :point_system, :affiliations
  accepts_nested_attributes_for :teams, allow_destroy: true

  # == Serializes
  serialize :category, Array


  private
    def init_point_system
      build_point_system if point_system.blank?
    end
end
