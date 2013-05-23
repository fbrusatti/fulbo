# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  slug                   :string(255)
#  provider               :string(255)
#  uid                    :string(255)
#  name                   :string(255)
#

class User < ActiveRecord::Base
  extend FriendlyId
  # == for nice url
  friendly_id :name, use: [:slugged, :history]


  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable,
         :recoverable, :rememberable, :trackable, :omniauthable,
         :omniauth_providers => [:facebook]

  # == Accessors
  attr_accessible :email, :password, :password_confirmation, :remember_me, :uid, :provider

  # == Associations
  has_many :own_teams, class_name: "Team"
  
  has_many :team_users
  has_many :teams, through: :team_users
  
  has_one :profile, dependent: :destroy,
                    class_name: 'UserProfile',
                    inverse_of: :user
  has_many :authorizations

  before_create :init_profile

  validate :name, :email, :presence => true
  

  def self.from_omniath(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
    end
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name:auth.extra.raw_info.name,
                         provider:auth.provider,
                         uid:auth.uid,
                         email:auth.info.email,
                         password:Devise.friendly_token[0,20]
                         )
    end
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
  
  private
    def init_profile
      build_profile
    end
end
