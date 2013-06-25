require 'spec_helper'

describe Turn do

  # belongs to
  it { should belong_to(:match) }
  it { should belong_to(:field) }

  it { should validate_presence_of(:date) }
  it { should allow_mass_assignment_of(:date) }
end
