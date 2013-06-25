require 'spec_helper'

describe Goal do

  # belongs to
  it { should belong_to(:match) }
  it { should belong_to(:team_user) }
end
