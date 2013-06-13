# == Schema Information
#
# Table name: locations
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  address     :string(255)
#  phone       :string(255)
#  locality    :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Location do
  # validate presences
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:address) }

  # mass assignments
  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:description) }
  it { should allow_mass_assignment_of(:phone) }
  it { should allow_mass_assignment_of(:address) }
  it { should allow_mass_assignment_of(:locality) }

  # belongs_to
  it { should belong_to(:sport_center) }

end