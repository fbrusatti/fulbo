require 'spec_helper'

describe Gallery do

  it { should belong_to(:team) }
  it { should have_db_column(:team_id).of_type(:integer)}

  it { should have_many(:photos) }

end
