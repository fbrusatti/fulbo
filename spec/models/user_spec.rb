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

require 'spec_helper'

describe User do
  it { should have_one(:profile) }

  # he is an owner
  it { should have_one(:team) }

  it { should have_many(:team_users) }
  it { should have_many(:teams).through(:team_users) }
end
