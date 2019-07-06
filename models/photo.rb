require 'carrierwave'
require 'carrierwave/orm/activerecord'

class ImageUploader < CarrierWave::Uploader::Base
  storage :file
end

class Photo < ActiveRecord::Base
  mount_uploader :image_file_name, ImageUploader
end