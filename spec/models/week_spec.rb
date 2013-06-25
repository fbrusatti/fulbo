require 'spec_helper'

describe Week do
  # belongs to
  it { should belong_to(:fixture) }

  #has many
  it { should have_many(:matches) }
end
