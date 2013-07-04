class Match < ActiveRecord::Base

  # == Associations
  belongs_to :week
  belongs_to :visitor, class_name: "Team"
  belongs_to :local, class_name: "Team"
  has_one :reservation
  has_many :cards
  has_many :goals

  attr_accessible :local_tokens, :visitor_tokens
  # == attr reader
  attr_reader :local_tokens, :visitor_tokens

  def local_tokens=(ids)
      self.local_ids = ids.split(",")
  end  
  def visitor_tokens=(ids)
      self.visitor_ids = ids.split(",")
  end  
end
