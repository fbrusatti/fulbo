# == Schema Information
#
# Table name: team_users
#
#  id         :integer          not null, primary key
#  team_id    :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe TeamUser do

  #belongs to
  it { should belong_to(:user) }
  it { should belong_to(:team) }

  #has many
  it { should have_many(:goals) }
  it { should have_many(:cards) }
end
