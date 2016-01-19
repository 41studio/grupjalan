# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # default image when no picture uploaded
  def default_url
    ActionController::Base.helpers.asset_url('nopic.jpg')
  end

 def smart_crop_and_scale(width, height)
    manipulate! do |img|
      img = SmartCropper.new(img)
      img = img.smart_crop_and_scale(width, height)
      img = yield(img) if block_given?
      img
    end
 end


  version :thumb do
    process :smart_crop_and_scale => [50, 50]
    # process :resize_to_fill => [50, 50]
    
  end

  version :small do
    process :smart_crop_and_scale => [100, 100]
    # process :resize_to_fill => [100, 100]
  end

  version :medium do 
    process :smart_crop_and_scale => [140, 100]
    # process :resize_to_fill => [140, 100]
  end 

  version :reg do
    process :smart_crop_and_scale => [500, 500]
  end  

  version :cover do
    # process :smart_crop_and_scale => [1140, 315]
    process :resize_to_fill => [1140, 315]
  end

  version :logo do
    process :smart_crop_and_scale => [160, 160]
    # process :resize_to_fill => [160, 160]
    # process crop: '160x160+0+0'
  end

  version :home do
    process :smart_crop_and_scale => [1200, 400]
  end  

  version :sosmall do
    process :resize_to_fill => [50, 50]

  end  

   
  def extension_white_list
    %w(jpg jpeg gif png)
  end


   # private

   #  # Jalan Sementara
   #  def crop(geometry)
   #    manipulate! do |img|      
   #      img.crop(geometry)
   #      img
   #    end    
   #  end

   #  # Fungsi untuk crop photo
   #  def resize_and_crop(size)  
   #    manipulate! do |image|                 
   #      if image[:width] < image[:height]
   #        remove = ((image[:height] - image[:width])/2).round 
   #        image.shave("0x#{remove}") 
   #      elsif image[:width] > image[:height] 
   #        remove = ((image[:width] - image[:height])/2).round
   #        image.shave("#{remove}x0")
   #      end
   #      image.resize("#{size}x#{size}")
   #      image
   #    end
   #  end
end
