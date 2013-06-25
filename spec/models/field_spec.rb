# == Schema Information
#
# Table name: fields
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  surface     :string(255)
#  category    :string(255)
#  price       :decimal(8, 2)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Field do
  # validate presences
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:surface) }
  it { should validate_presence_of(:category) }

  # mass assignments
  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:surface) }
  it { should allow_mass_assignment_of(:category) }
  it { should allow_mass_assignment_of(:price) }
  it { should allow_mass_assignment_of(:description) }

  # belongs_to
  it { should belong_to(:location) }

  # has_many
  it { should have_many(:turns) }
end
