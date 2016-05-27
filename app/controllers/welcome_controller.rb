class WelcomeController < ApplicationController
  def index
    @projects = Project.limit(2)
  end
end
