class League < ActiveRecord::Base

  # == Includes
  include RRSchedule

  # == Accessors
  attr_accessible :name, :category, :number_matches, :field_price, :registration_price,
                  :requirements, :number_teams, :start_date, :point_system_attributes,
                  :affiliations_attributes, :teams_attributes, :organizer_id

  # == Validations
  validates_presence_of :name, :category, :start_date

  # == Associations
  belongs_to :organizer, class_name: 'SportCenter'
  has_one :point_system, dependent: :destroy, inverse_of: :league
  has_one :fixture, dependent: :destroy
  has_many :affiliations, dependent: :destroy
  has_many :teams, through: :affiliations
  has_many :inscription_requests,
           class_name: 'RequestInscription',
           as: :requested

  # == Callbacks
  before_create :init_point_system

  # == Nested Attributes
  accepts_nested_attributes_for :point_system, :affiliations
  accepts_nested_attributes_for :teams, allow_destroy: true

  # == Instance Methods
  def affiliate(team)
    affiliations.create(team_id: team.id)
  end

  def unaffiliated(team)
    affiliations.find_by_team_id(team.id).destroy
  end

  def generate_fixture(rules)
    schedule = RRSchedule::Schedule.new(teams: self.team_ids,
                                        rules: rules,
                                        start_date: self.start_date
                                       ).generate
    fixture = create_fixture
    schedule.gamedays.each_with_index do |gd, index|
      week = fixture.weeks.create(number: index, start_date: gd.date)
      gd.games.each do |game|
        match = week.matches.create(visitor_id: game.team_a,
                                    local_id: game.team_b)
        match.create_reservation(field_id: game.playing_surface.to_i,
                                 reservation_date:  game.game_time)
      end
    end
  end

  private
    def init_point_system
      build_point_system if point_system.blank?
    end
end
