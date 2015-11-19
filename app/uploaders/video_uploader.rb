class VideoUploader < CarrierWave::Uploader::Base
  include CarrierWave::Video
  
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end 
end