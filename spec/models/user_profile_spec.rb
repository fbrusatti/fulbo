# == Schema Information
#
# Table name: user_profiles
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  surname          :string(255)
#  nickname         :string(255)
#  playing_position :string(255)
#  locality         :string(255)
#  foot             :string(255)
#  features         :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  avatar           :string(255)
#  dob              :date
#

require 'spec_helper'

describe UserProfile do
  it { should belong_to(:user) }
  it { should have_db_column(:user_id).of_type(:integer)}

  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:surname) }
  it { should allow_mass_assignment_of(:nickname) }
  it { should allow_mass_assignment_of(:playing_position) }
  it { should allow_mass_assignment_of(:locality) }
  it { should allow_mass_assignment_of(:foot) }
  it { should allow_mass_assignment_of(:avatar) }
  it { should allow_mass_assignment_of(:features) }
  it { should ensure_length_of(:features).is_at_most(200) }  

end
