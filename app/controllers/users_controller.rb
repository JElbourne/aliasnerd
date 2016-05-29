class UsersController < ApplicationController
  before_action :authenticate_user!
  def liked
    current_user.add_like unless current_user.liked
    redirect_to :back
  end
end
