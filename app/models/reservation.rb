class Reservation < ActiveRecord::Base

  # == Associations
  belongs_to :match
  belongs_to :field
  belongs_to :user

  # == Accessors
  attr_accessible :reservation_date, :field_id

  # == Validations
  validates_presence_of :reservation_date

  # == Public Methods
  def as_json(options = {})
    {
      :id => id,
      :title => 'Reservation',
      :description => 'description' || "",
      :start => reservation_date.rfc822,
      :end => (reservation_date + 1.hour).rfc822,
      :recurring => false,
      :allDay => false,
      :url => Rails.application.routes.url_helpers.reservation_path(id)
    }
  end

  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
  end
end
