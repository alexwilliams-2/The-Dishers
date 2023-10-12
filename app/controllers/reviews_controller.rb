class ReviewsController < ApplicationController
  before_action :set_business
  before_action :set_review, only: %i[edit update destroy]

  def new
    @review = Review.new
    authorize @review
    redirect_to business_path(@business)
  end

  def create
    @review = Review.new(review_params)
    @review.business = @business
    @review.user = current_user
    authorize @review
    @review.save
    if @review.save
      redirect_to business_path(@business)
    else
      redirect_to business_path(@business), alert: "#{@review.errors.full_messages.join(", ")}"
    end
  end

  def edit
    authorize @review
  end

  def update
    authorize @review
    if @review.update(review_params)
      redirect_to business_path(@business), notice: 'Review was successfully updated.'
    else
      render "reviews/edit", :locals => {:review => @review, :business => @business}, status: :unprocessable_entity
    end
  end


  def destroy
    authorize @review
    @review.destroy
    redirect_to business_path(@business), status: :see_other
  end

  private

  def set_business
    @business = Business.find(params[:business_id])
  end

  def review_params
    params.require(:review).permit(:title, :content, :job_title, :rating, :wage, :votes, :user_review)
  end

  def set_review
    @review = Review.find(params[:user_review])
    authorize @review
  end

end
