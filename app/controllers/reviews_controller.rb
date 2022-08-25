class ReviewsController < ApplicationController
  before_action :set_offer

  def new
    # @offer = Offer.find(params[:offer_id])
    @review = Review.new
    authorize @review
  end

  def create
    @review = Review.new(review_params)
    @review.offer = @offer

    authorize @review

    if @review.save
      redirect_to offer_path(@offer)
    else
      @booking = Booking.new
      render "offers/show", status: :unprocessable_entity

    end
  end

  private

  def set_offer
    @offer = Offer.find(params[:offer_id])
  end

  def review_params
    params.require(:review).permit(:content)
  end
end
