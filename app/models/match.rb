class Match < ActiveRecord::Base

  # == Associations
  belongs_to :week
  belongs_to :visitor, class_name: "Team"
  belongs_to :local, class_name: "Team"
  has_one :reservation, dependent: :destroy
  has_many :cards
  has_many :goals

  # == Accessors
  attr_accessible :reservation_attributes,:local_tokens, :visitor_tokens,
                  :visitor, :local , :week_attributes, :visitor_id, :local_id

  # == attr reader
  attr_reader :local_tokens, :visitor_tokens

  # == Nested Attributes
  accepts_nested_attributes_for :reservation, :local , :visitor, :week

  def visitor_tokens=(ids)
      self.visitor_id = ids
  end
  def local_tokens=(ids)
       self.local_id = ids
  end
end
