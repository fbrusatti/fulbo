class Match < ActiveRecord::Base

  # == Associations
  belongs_to :week
  belongs_to :visitor, class_name: "Team"
  belongs_to :local, class_name: "Team"
  has_one :reservation
  has_many :cards
  has_many :goals

  attr_accessible :local_tokens, :visitor_tokens, :reservation
  # == attr reader
  attr_reader :local_tokens, :visitor_tokens

  # # == Nested Attributes
  # accepts_nested_attributes_for :reservation

  def local_tokens=(ids)
      self.local_id = ids.split(",")
  end  
  def visitor_tokens=(ids)
      self.visitor_id = ids.split(",")
  end  
end
