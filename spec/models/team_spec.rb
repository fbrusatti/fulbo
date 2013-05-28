# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  captain    :integer
#  owner_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Team do

  # belongs_to
  it { should belong_to(:owner) }

  # has_one
  it { should have_one(:profile) }
  it { should have_one(:gallery) }

  # has_many
  it { should have_many(:team_users) }
  it { should have_many(:users).through(:team_users) }

  it { should have_db_column(:owner_id).
              of_type(:integer)}

  it { should validate_presence_of(:name) }

  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:captain) }

end
