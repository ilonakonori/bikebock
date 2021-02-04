class RidesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_ride, only: [:show, :edit, :update, :destroy]

  def index # filter & search here
    if params[:query].present?
      @rides = filter.search_rides(params[:query])
    else
      filter
    end
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
      redirect_to ride_path(@ride)
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

  def filter # add available dates (order earliest)
    case params[:select]
      when '2' # ratings # we don't have this atm!
        @rides = policy_scope(Ride).order(ratings: :desc)
      when '3' # difficulty asc
        @rides = policy_scope(Ride).order(difficulty: :asc)
      when '4' # difficulty desc
        @rides = policy_scope(Ride).order(difficulty: :desc)
      when '5' # num of people asc
        @rides = policy_scope(Ride).order(number_of_people: :asc)
      when '6' # num of people desc
        @rides = policy_scope(Ride).order(number_of_people: :desc)
    else # '1' ie. default
      @rides = policy_scope(Ride).order(created_at: :desc)
    end
  end

  def ride_params
    params.require(:ride).permit(:title, :short_description, :start_location, :start_time, :end_location, :end_time, :difficulty, :number_of_people, :available_dates, :user_id, photos: [])
  end

  def set_ride
    @ride = Ride.find(params[:id])
    authorize @ride
  end
end
