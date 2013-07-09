class Affiliation < ActiveRecord::Base
  # == Accessors
  attr_accessible :team_id

  # == Associations
  belongs_to :league
  belongs_to :team

  # == Callbacks
  after_create :accepting_inscription_request
  after_destroy :rejecting_inscription_request

  def accepting_inscription_request
    inscription = team.inscription_requesters.where(status: :waiting)
                                             .find_by_requested_id(league)
    inscription.mark(:accepted) if inscription
  end

  def rejecting_inscription_request
    inscription = team.inscription_requesters.where(status: :accepted)
                                             .find_by_requested_id(league)
    inscription.mark(:rejected) if inscription
  end
end
