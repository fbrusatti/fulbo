require 'spec_helper'

describe Photo do

  it { should belong_to(:gallery) }
  it { should have_db_column(:gallery_id).of_type(:integer)}

  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:image) }
  it { should allow_mass_assignment_of(:remote_image_url) }

end
