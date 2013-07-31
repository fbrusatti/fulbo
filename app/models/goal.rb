class Goal < ActiveRecord::Base
	
 
  # == Associations
  belongs_to :match
  belongs_to :team_user

  attr_accessible :time, :description, :count, :team_user_id

  accepts_nested_attributes_for :team_user

  # == Validations
  validates_presence_of :count, :match, :team_user
  validates :description, length: {maximum: 200}
  validate :not_duplicate_shooter

  def not_duplicate_shooter
    shothers = Goal.where(match_id: match.id).where(team_user_id: team_user.id)
    if !shothers.blank?
      errors.add(:team_user,I18n.t('flash.not_duplicate_shooter'))
    end  
  end  


end
