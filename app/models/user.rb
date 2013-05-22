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
#

class User < ActiveRecord::Base
  extend FriendlyId
  # == for nice url
  # friendly_id :name, use: [:slugged, :history]
  friendly_id :name, use: :slugged


  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # == Accessors
  attr_accessible :email, :password, :password_confirmation, :remember_me

  # == Associations
  has_one :profile, dependent: :destroy,
                    class_name: 'UserProfile',
                    inverse_of: :user

  before_create :init_profile

  private
  def init_profile
    build_profile
  end
end
