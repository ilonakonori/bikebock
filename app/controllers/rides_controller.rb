class RidesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_ride, only: [:show, :edit, :update, :destroy, :fav, :unfav]
  after_action :read_review_notifications, only: :show

  def index # filter
    case params[:select]
      when '3' # ratings
        @rides = policy_scope(Ride).includes([:user, :reviews]).total_valid(current_user).sort_by { |r| r.rating }.reverse!
      when '4' # difficulty asc
        @rides = policy_scope(Ride).order(:difficulty).includes([:user, :reviews]).total_valid(current_user)
      when '1' # num of people asc
        @rides = policy_scope(Ride).order(:number_of_people).includes([:user, :reviews]).total_valid(current_user)
    else # 2 => default => available_dates: :asc  => earliest
      @rides = policy_scope(Ride).includes([:user, :reviews]).total_valid(current_user).sort_by { |r| r.valid_dates.first }
    end
    update_tracking
  end

  def show # imp
    @blocked = current_user.blockings.find_by(blocked_user: @ride.user.id)
    @blocked_current = @ride.user.blockings.find_by(blocked_user: current_user.id)

    requests = Request.where(ride_id: @ride.id, user_id: current_user, recipient_id: @ride.user_id)
    all_dates = requests.map { |r| r.ride_date.to_date }
    ride_dates = @ride.valid_dates
    my_dates = (ride_dates + all_dates)

    @av_dates = my_dates.select { |d| my_dates.count(d) == 1 }
    # remove reviews from blocked
    if @ride.reviews.present?
      @reviews = filter_blocked(@ride.reviews.order(created_at: :desc), 'participant')
    end

    @request = Request.new
    update_tracking
  end

  def new
    @ride = current_user.rides.new
    update_tracking
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
    update_tracking
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
    update_tracking
  end

  def destroy
    @ride.destroy
    update_tracking
    redirect_to user_path(current_user), notice: 'Ride was succesfully removed!'
  end

  def fav
    current_user.favorite(@ride)
  end

  def unfav
    current_user.unfavorite(@ride)
  end

  def update_tracking
    tracking = Tracking.find_by(user: current_user.id)
    tracking.update!(location: request.url, location_time: Time.now)
  end

  def filter_blocked(this_users, this_id)
    # don't display users that current_user blocked
    blocked_users = current_user.blockings.map { |b| b.blocked_user }
    # don't display users that blocked current_user
    user_blocked_by = Blocking.all.select do |b|
                        if b.blocked_user == current_user.id
                          b
                        end
                      end.map { |b| b.user_id }

    this_users.reject do |t|
      if blocked_users.include?(t.booking[this_id]) || user_blocked_by.include?(t.booking[this_id])
        t
      end
    end
  end

  def read_review_notifications
    reviews = Notification.where(read: false, action: 'Review', link: "/rides/#{@ride.id}", user: current_user)
    if reviews.present?
      reviews.each do |n|
        n.update(read: true, read_at: Time.now)
      end
    end
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
