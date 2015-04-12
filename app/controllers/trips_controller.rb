class TripsController < ApplicationController

	def new
		@trip=Trip.new
		respond_to do |format|
			format.html{}
		end
	end

	# def show

	# 	@users=User.all
	# 	@trip= Trip.find(params[:id])
	# 	respond_to do |format|
	# 		format.js{}
	# 	end
	# end

	def create
		@trip=Trip.new(trip_params)
		@trip.user_id=current_user.id
		if @trip.valid? && @trip.errors.blank?
			@trip.save
			respond_to do |format|
				format.html{
					redirect_to root_path,:notice => "Trip Created!"
				}
			end
		else
			redirect_to root_path, :notice => "Trip cannot be Created!"
		end
	end

	def index
		@trip=Trip.all
		@trips = Trip.order("updated_at desc")
		@trips.each do|trip|
			if trip.present?	
				@trip=@trips.first
			else
				redirect_to trips_path, :notice => "No events"
			end
		end
	end

	private

	def trip_params
		params.require(:trip).permit(:title, :description, :content, :main_image)
	end
end