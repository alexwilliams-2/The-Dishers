class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def profile #for users
    @user = current_user
    @favourites = @user.user_favourites
  end

end
