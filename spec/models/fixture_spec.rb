require 'spec_helper'

describe Fixture do

  # belongs to
  it { should belong_to(:league) }

  #has many
  it { should have_many(:weeks) }
end
