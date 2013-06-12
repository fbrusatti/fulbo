require 'spec_helper'

describe PointSystem do

  # validate presences
  it { should validate_presence_of(:win) }
  it { should validate_presence_of(:tie) }
  it { should validate_presence_of(:loser) }


  # mass assignments
  it { should allow_mass_assignment_of(:win) }
  it { should allow_mass_assignment_of(:tie) }
  it { should allow_mass_assignment_of(:loser) }

  # belongs_to
  it { should belong_to(:league) }
end

