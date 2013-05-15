class Authorization < ActiveRecord::Base
  attr_accessible :provider, :uid, :user_id, :token, :secret, :name, :link
  belongs_to :user
  validates :uid, :provider, :presence => true

end
