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

  def payment_verification
    session_id = params[:session_id]
    
    if session_id.present?
      session = Stripe::Checkout::Session.retrieve(session_id)

      if session.payment_status == 'paid'
        gym_class_id = session.metadata.gym_class_id
        gym_class = GymClass.find(gym_class_id)

        @booking = current_user.bookings.create!(gym_class: gym_class)
        redirect_to bookings_url
      end
    else
      redirect_to gym_classes_path
    end
  end

  # PATCH/PUT
  def update
  end

  # DELETE
  def destroy
    @booking = current_user.bookings.find(params[:id])
    @booking.destroy
    redirect_to bookings_path
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
