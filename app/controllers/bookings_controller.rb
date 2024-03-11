class BookingsController < ApplicationController

  # GET /bookings or /bookings.json
  def index
    @bookings = Booking.all
  end

  # GET /bookings/1 or /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST
  def create
    @booking = current_user.bookings.build
    @booking.gym_class_id = params[:gym_class_id]
  
    if @booking.save
      redirect_to bookings_url
    else
      render :index
    end
  end

  # PATCH/PUT
  def update
  end

  # DELETE
  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def booking_params
      params.fetch(:booking, {})
    end
end
