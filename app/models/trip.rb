# Trip Model
class Trip < ActiveRecord::Base
  has_many :comments
  belongs_to :user
  mount_uploader :main_image, ImageUploader
  # def check_update(old_trip_story,new_trip_story)
  #   if old_trip_story.description!=new_trip_story[:description]||old_event.content!=new_trip_story[:content]
  #
  #     UpdateMail.update_event(old_event,new_event).deliver
  #   end
  # end
end
