require 'spec_helper'

describe Photo do

  # belongs_to
  it { should belong_to(:team) }

  # mass assigmente
  it { should allow_mass_assignment_of(:name) }

end
