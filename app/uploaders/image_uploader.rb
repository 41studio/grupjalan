# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end
  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

#   def smart_crop_and_scale(width, height)
#     manipulate! do |img|
#       img = SmartCropper.new(img)
#       img = img.smart_crop_and_scale(width, height)
#       img = yield(img) if block_given?
#       img
#     end
# end


  version :logo do 
    process :resize_to_fill => [160, 160]
    process crop: '160x160+0+0'
  end


  private

    # Simplest way
    def crop(geometry)
      manipulate! do |img|      
        img.crop(geometry)
        img
      end    
    end

    # Resize and crop square from Center
    def resize_and_crop(size)  
      manipulate! do |image|                 
        if image[:width] < image[:height]
          remove = ((image[:height] - image[:width])/2).round 
          image.shave("0x#{remove}") 
        elsif image[:width] > image[:height] 
          remove = ((image[:width] - image[:height])/2).round
          image.shave("#{remove}x0")
        end
        image.resize("#{size}x#{size}")
        image
      end
    end
end
