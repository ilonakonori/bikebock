class RidesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_ride, only: [:show, :edit, :update, :destroy]

  def index # search here
    @rides = policy_scope(Ride).order(created_at: :desc)
  end

  def show
  end

  def new
    @ride = current_user.rides.new
    authorize @ride
  end

  def create
    @ride = current_user.rides.new(ride_params)
    authorize @ride
    if @ride.save
      redirect_to rides_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @ride.update(ride_params)
    if @ride.save
      redirect_to @ride
    else
      render :edit
    end
  end

  def my_rides
    @rides = current_user.rides
    authorize @rides
  end

  def destroy
    @ride.destroy
    redirect_to my_rides_rides_path, notice: 'Ride was succsesfully removed!'
  end

  private

  def ride_params
    params.require(:ride).permit(:title, :short_description, :start_location, :start_time, :end_location, :end_time, :difficulty, :number_of_people, :available_dates, :user_id, photos: [])
  end

  def set_ride
    @ride = Ride.find(params[:id])
    authorize @ride
  end
end
