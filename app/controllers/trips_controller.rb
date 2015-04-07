class TripsController < ApplicationController

	def new
		@event=Event.new
		respond_to do |format|
			format.js{}
		end
	end

	def show

		@users=User.all
		@event= Event.find(params[:id])
		@invitee=Invitee.where(event_id:@event)
		@participants=@event.selectInvitee(@event.id)
		respond_to do |format|
			format.js{}
		end
	end

	def create
		@trip=Trip.new(trip_params)
		@trip.user_id=current_user.id
		if @trip.valid? && @trip.errors.blank?
			@trip.save
			respond_to do |format|
				format.html{
					redirect_to trips_path,:notice => "Event Created!"
				}
			end
		else
			redirect_to trips_path, :notice => "Event cannot be Created!"
		end
	end

	def index
		@users=User.all
		@events = Event.order("updated_at desc").page(params[:page]).per(5)
		@events.each do|event|
			if event.present?	
				@event=@events.first
				@participants=@event.selectInvitee(@event.id)
				@user=@event.notparticipants(@event.id)
			else
				redirect_to events_path, :notice => "No events"
			end
		end
	end

	private

	def trip_params
		params.require(:trip).permit(:title, :description, :content, :main_image)
	end
end