class Authorization < ActiveRecord::Base
  attr_accessible :provider, :uid, :user_id
  belong_to :user
  validates :uid, :provider, :presence => true
end
