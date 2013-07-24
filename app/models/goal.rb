class Goal < ActiveRecord::Base
	
  # scope :by_team, lambda { |team| joins(:team_user).where('team_user.team = ?',team)}
  
  
  # == Associations
  belongs_to :match
  belongs_to :team_user

  attr_accessible :time, :description, :count, :team_user_id

  accepts_nested_attributes_for :team_user

  before_create :check_one_off
  # == Validations
  validates_presence_of :count, :match, :team_user
  validates :description, length: {maximum: 200}

  private
  def check_one_off
  	# duplicate = Goal.where(match: :match, team_user: :team_user)
  	# if duplicate == nil
  	# 	true
  	# else
  	# 	false
  	# end	
  end 

end
