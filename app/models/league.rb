class League < ActiveRecord::Base

  # == Accessors
  attr_accessible :name, :category, :number_matches, :field_price, :description,
                  :registration_price, :requirements, :number_teams, :start_date

  # == Validations
  validates_presence_of :name, :category, :start_date

  # == Associations
  belongs_to :organizer, class_name: 'SportCenter'
  has_one :point_system, dependent: :destroy
  has_many :affiliations, dependent: :destroy
  has_many :teams, through: :affiliations

  # == Callbacks
  before_create :init_point_system

  # == Nested Attributes
  accepts_nested_attributes_for :point_system

  private
    def init_point_system
      build_point_system if point_system.blank?
    end
end
