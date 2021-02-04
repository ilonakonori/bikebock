class RidesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_ride, only: [:show, :edit, :update, :destroy]

  def index # filter & search here  # wip
    if params[:query].present?
      user_select = params[:select]
      rides = policy_scope(Ride).search_rides(params[:query])
      filter(user_select, rides)  # select not working :/
    else
      user_select = params[:select]
      rides = policy_scope(Ride)
      filter(user_select, rides)
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

  def filter(user_select, rides) # add available dates (order earliest)
    case user_select
      when '2' # ratings # we don't have this atm!
        @rides = rides.order(ratings: :desc)
      when '3' # difficulty asc
        @rides = rides.order(difficulty: :asc)
      when '4' # difficulty desc
        @rides = rides.order(difficulty: :desc)
      when '5' # num of people asc
        @rides = rides.order(number_of_people: :asc)
      when '6' # num of people desc
        @rides = rides.order(number_of_people: :desc)
    else # '1' ie. default
      @rides = rides.order(created_at: :desc)
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
