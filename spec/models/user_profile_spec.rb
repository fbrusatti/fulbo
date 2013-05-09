# == Schema Information
#
# Table name: user_profiles
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe UserProfile do
  
  it { should belong_to(:user) }
  it { should have_db_column(:user_id).of_type(:integer)}

  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:surname) }
  it { should allow_mass_assignment_of(:nickname) }
  it { should allow_mass_assignment_of(:playing_position) }
  it { should allow_mass_assignment_of(:born) }
  it { should allow_mass_assignment_of(:locality) }
  it { should allow_mass_assignment_of(:foot) }
  it { should allow_mass_assignment_of(:avatar) }
  it { should allow_mass_assignment_of(:features) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:surname) }
  it { should validate_presence_of(:playing_position) }

  values = %w(Goalkeeper Defender Midfielder Forward Coach Coaching staff Referee Assistant referee)
  it { should allow_value(values).for(:playing_position) }
  it { should ensure_length_of(:features).is_at_most(200) }  


end
