require 'spec_helper'

describe TeamProfile do

  it { should belong_to(:team) }
  it { should have_db_column(:team_id).of_type(:integer)}

  it { should allow_mass_assignment_of(:category) }
  it { should allow_mass_assignment_of(:surface) }
  it { should allow_mass_assignment_of(:geo_availability) }
  it { should allow_mass_assignment_of(:badge) }
  it { should allow_mass_assignment_of(:description) }

  values = ("5 6 7 8 9 10 11")
  it { should allow_value(values).for(:category) }

  values = ("sand grass parquet synthetic_grass land cement")
  it { should allow_value(values).for(:surface) }

  it { should ensure_length_of(:description).is_at_most(200) }
end
