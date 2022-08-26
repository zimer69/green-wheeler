class OffersController < ApplicationController
  before_action :set_offer, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @offers = policy_scope(Offer)

    # home page search for location
    if params[:address].present?
      @offers = @offers.search_by_address(params[:address])
      if @offers.empty?
        @close_offers_exist = false
        @offers = policy_scope(Offer).where.not(user: current_user)
      end
    else
      @offers = @offers.where.not(user: current_user)
    end

    # offers page search for specific offer
    sql_query = "@offers.title @@ :query OR @offers.description @@ :query"
    @offers = @offers.search_by_title_and_description(params[:query]) if params[:query].present?

    # filtering the checkboxes
    @offers = @offers.search_by_electric(true) if params[:electric].present?
    @offers = @offers.search_by_safety_equipment(true) if params[:safety_equipment].present?
    @offers = @offers.search_by_optional('Padlock') if params[:padlock].present?
    @offers = @offers.search_by_optional('Backseat') if params[:backseat].present?

    # map for offers
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
    @review = Review.new
    @average = Offer.average(:rating)
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
    @offers = policy_scope(Offer)
    authorize @offers
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
