# Trip Model
class Trip < ActiveRecord::Base
  is_impressionable
  has_many :comments
  belongs_to :user
  mount_uploader :main_image, ImageUploader

  # Elastic Search
  include Tire::Model::Search
  include Tire::Model::Callbacks

  def self.search(params)
    tire.search(load: true, page: params[:page], per: 6) do
      query { string params[:query] } if params[:query].present?
      sort { by :updated_at, 'desc'}
    end
  end

  def checkpoint_address(params)
    checkpointArray = Array.new
    if params.count > 5
      (6..params.count - 1).each do |position|
        point= position-4
        checkpointArray.push(params["checkpoint#{point}"])
      end
    end
    checkpointArray
  end

  # def check_update(old_trip_story,new_trip_story)
  #   if old_trip_story.description!=new_trip_story[:description]||old_event.content!=new_trip_story[:content]
  #
  #     UpdateMail.update_event(old_event,new_event).deliver
  #   end
  # end
end
