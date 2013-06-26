require 'spec_helper'

describe Week do
  # belongs to
  it { should belong_to(:fixture) }

  #has many
  it { should have_many(:matches) }

  #validate
  it { should validate_presence_of(:number) }
end
