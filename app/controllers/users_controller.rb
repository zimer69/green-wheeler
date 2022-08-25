class UsersController < ApplicationController
  def show
    @user = current_user
    authorize @user
    @bookings = current_user.bookings
  end
end
