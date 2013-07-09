class RequestInscription < ActiveRecord::Base
  # == Accessors
  attr_accessible :requester_id, :requester_type, :requested_id,
                  :requested_type

  # == Associations
  belongs_to :requester, polymorphic: true
  belongs_to :requested, polymorphic: true

  def mark(mark_type)
    update_attribute(:status, mark_type.to_s)
  end
end
