require 'spec_helper'

describe Affiliation do
  # belongs to
  it { should belong_to(:league) }
  it { should belong_to(:team) }
end
