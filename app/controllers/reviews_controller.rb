class ReviewsController < ApplicationController
  before_action :set_business, only: %i[new create]

  def new
    @business = Business.find(params[:business_id])
    @review = Review.new
    redirect_to business_path(@business)
  end

  def create
    @review = Review.new(review_params)
    @review.business = @business
    @review.user = current_user
    @review.save
    if @review.save
      redirect_to business_path(@business)
    else
      render :template => "businesses/show", :locals => {:review => Review.new}, status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy
    redirect_to business_path(@business), status: :see_other
  end

  private

  def set_business
    @business = Business.find(params[:business_id])
  end

  def review_params
    params.require(:review).permit(:title, :content, :job_title, :rating, :wage, :votes)
  end
end
