class BookingsController < ApplicationController
  before_action :set_booking, only: %i[show edit update destroy]
  before_action :set_booking_offer, only: %i[new create]

  def index
    @bookings = policy_scope(Booking)
  end

  def show
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.offer = @offer

    authorize @booking

    if @booking.save
      redirect_to @booking, notice: "Booking was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @booking
  end

  def update
    authorize @booking

    if @booking.update(booking_params)
      redirect_to @booking, notice: "Booking was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @booking

    @booking.destroy
    redirect_to bookings_path, notice: "Booking was successfully destroyed."
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def set_booking_offer
    @offer = Offer.find(params[:offer_id])
  end

  def booking_params
    params.require(:booking).permit(
      :start_date,
      :end_date,
      :user_id,
      :offer_id
    )
  end
end
