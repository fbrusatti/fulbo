require 'spec_helper'

describe SportCenter do

  # validate presences
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:cuit) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:email) }

  # mass assignments
  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:cuit) }
  it { should allow_mass_assignment_of(:description) }
  it { should allow_mass_assignment_of(:phone) }
  it { should allow_mass_assignment_of(:address) }
  it { should allow_mass_assignment_of(:email) }
  it { should allow_mass_assignment_of(:owner_id) }

  # has many
  it { should have_many(:leagues) }
  it { should have_many(:locations) }

end

