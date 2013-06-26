require 'spec_helper'

describe Reservation do

  # belongs to
  it { should belong_to(:match) }
  it { should belong_to(:field) }

  it { should validate_presence_of(:reservation_date) }
  it { should allow_mass_assignment_of(:reservation_date) }
end
