class Authorization < ActiveRecord::Base
  attr_accessible :provider, :uid, :user_id, :token
  belongs_to :user
  validates :uid, :provider, :token, :presence => true

end
