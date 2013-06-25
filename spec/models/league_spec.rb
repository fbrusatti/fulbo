require 'spec_helper'

describe League do

  # validate presences
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:category) }
  it { should validate_presence_of(:start_date) }

  # mass assignments
  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:category) }
  it { should allow_mass_assignment_of(:number_matches) }
  it { should allow_mass_assignment_of(:field_price) }
  it { should allow_mass_assignment_of(:registration_price) }
  it { should allow_mass_assignment_of(:requirements) }
  it { should allow_mass_assignment_of(:number_teams) }
  it { should allow_mass_assignment_of(:start_date) }


  # belongs to
  it { should belong_to(:organizer) }

  # has one
  it { should have_one(:point_system) }
  it { should have_one(:fixture) }

  #has many
  it { should have_many(:affiliations) }
  it { should have_many(:teams).through(:affiliations) }

  # nested attributes
  it { should accept_nested_attributes_for(:point_system) }

  it "each league has a point system associated when it is created" do
    league = FactoryGirl.create(:league)
    assert_not_nil league.point_system
  end
end
