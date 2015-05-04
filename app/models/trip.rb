class Trip < ActiveRecord::Base

	has_many :comments
	belongs_to :user
	mount_uploader :main_image, ImageUploader
end
