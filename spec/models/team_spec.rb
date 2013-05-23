# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  captain    :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Team do
  
  # owner
  it { should belong_to(:owner) }
  it { should have_db_column(:user_id).
              of_type(:integer)}

  # team users
  it { should have_many(:team_users) }
  it { should have_many(:users).through(:team_users) }
  
  it { should validate_presence_of(:name) }

  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:captain) }

end
