require 'spec_helper'

describe Match do

  # belongs to
  it { should belong_to(:week) }
  it { should belong_to(:visitor).class_name("Team") }
  it { should belong_to(:local).class_name("Team") }

  #has many
  it { should have_many(:goals) }
  it { should have_many(:cards) }

  #has one
  it { should have_one(:reservation) }

end
