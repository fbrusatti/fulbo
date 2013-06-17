# == Schema Information
#
# Table name: fields
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  type        :string(255)
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
  it { should validate_presence_of(:type) }
  it { should validate_presence_of(:category) }

  # mass assignments
  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:type) }
  it { should allow_mass_assignment_of(:category) }
  it { should allow_mass_assignment_of(:price) }
  it { should allow_mass_assignment_of(:description) }

  # belongs_to
  it { should belong_to(:location) }
end
