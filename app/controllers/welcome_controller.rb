class WelcomeController < ApplicationController
  def index
    @projects = Project.limit(3)
    @liked_count = User.get_liked_count
    @subs_count = User.get_subs_count
    @current_user_liked = false
    if current_user
      @current_user_liked = true if current_user.liked
    end
  end
end
