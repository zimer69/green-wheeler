class OffersController < ApplicationController
  before_action :set_offer, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index

    # home page search for location
    if params[:address].present?
      @offers = policy_scope(Offer).search_by_address(params[:address])

    else
      @offers = policy_scope(Offer)
    end

    # offers page search for specific offer
    sql_query = "@offers.title @@ :query OR @offers.description @@ :query"
    if params[:query].present?
      @offers = @offers.search_by_title_and_description(params[:query])
    else
      @offers = policy_scope(Offer).search_by_address(params[:address])
    end

    @markers = @offers.geocoded.map do |offer|
      {
        lat: offer.latitude,
        lng: offer.longitude,
        info_window: render_to_string(partial: "info_window", locals: { offer: offer })
      }
    end

  end

  def show
    authorize @offer
    @booking = Booking.new
    authorize @booking
  end

  def my_offers
    @offers = policy_scope(Offer)
    authorize @offers
  end

  def new
    @offer = Offer.new
    authorize @offer
  end

  def create
    @offer = Offer.new(offer_params)
    @offer.user = current_user

    authorize @offer

    if @offer.save
      redirect_to @offer, notice: "Offer was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @offer
  end

  def update
    authorize @offer

    if @offer.update(offer_params)
      redirect_to @offer, notice: "Offer was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @offer

    @offer.destroy
    redirect_to offers_path, notice: "Offer was successfully destroyed."
  end

  private

  def set_offer
    @offer = Offer.find(params[:id])
  end

  def offer_params
    params.require(:offer).permit(:category,
                                  :price,
                                  :rating,
                                  :user_id,
                                  :title,
                                  :description,
                                  :electric,
                                  :safety_equipment,
                                  :address,
                                  :optional,
                                  photos: []
                                 )
  end
end
