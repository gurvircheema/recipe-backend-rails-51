class Picture < ApplicationRecord
  validates_presence_of :file
  belongs_to :recipe
  mount_base64_uploader :file, PictureUploader
end
