# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Photo < ActiveRecord::Base

  # == Associations
  belongs_to :team

  # == Accessors
  attr_accessible :name, :image, :remote_image_url

  # == Mount
  mount_uploader :image, ImageUploader

end