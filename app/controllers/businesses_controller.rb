class BusinessesController < ApplicationController
  def index
    @business = business.all
  end

  def show
    @business = business.find(params[:id])
  end

end
