# Trip Controller
class TripsController < ApplicationController
  before_filter :require_login, only: [:new]

  def new
    @trip = Trip.new
  end

  def show
    @users = User.all
    @trip = Trip.find(params[:id])
    @user = @trip.user
    respond_to do |format|
      format.html {}
    end
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.waypoints = @trip.checkpoint_address(params["trip"])
    @trip.user_id = current_user.id
    if @trip.valid? && @trip.errors.blank?
      @trip.save
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Trip Created!' }
      end
    else
      redirect_to root_path, notice: 'Trip cannot be Created!'
    end
  end

  def edit
    @users = User.all
    @trip = Trip.find(params[:id])
    respond_to do |format|
      format.html {}
    end
  end

  def update
    @trip = Trip.find(params[:id])
    if @trip.valid? && @trip.errors.blank?
      @trip.update(trip_params)
      respond_to do |format|
        format.html { redirect_to trip_path, notice: 'Trip Updated!' }
      end
    else
      redirect_to trip_path, notice: 'Trip cannot be Updated!'
    end
  end

  def index
    if params[:query].present?
      @trips = Trip.search(params)
    else
      @trips = Trip.all.page(params[:page]).per(6)
    end
    @trips.each do |trip|
      if trip.present?
        @trip = @trips.first
      else
        redirect_to trips_path, notice: 'No events'
      end
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:title, :description, :content, :main_image, :from_address, :to_address, :waypoints)
  end
end
