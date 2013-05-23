require 'spec_helper'

describe TeamUser do

  it { should belong_to(:user) }
  it { should belong_to(:team) }

end
