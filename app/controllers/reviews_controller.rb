class ReviewsController < ApplicationController
  before_action :set_business, only: %i[new create]

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.business = @business
    @review.user = current_user
    if @review.save
      redirect_to business_path(@business)
    else
      redirect_to business_path(@business), alert: "Feel free to criticize! But please keep your reviews clean and informative in order to better aid our community."
    end
  end

    # respond_to do |format|
    #   if @review.save
    #     format.html { redirect_to business_path(@business), notice: "Review was successfully created." }
    #     format.json { render :show, status: :created, location: @review }
    #   else
    #     format.html { redirect_to business_path(@business), status: :unprocessable_entity, alert: @review.errors.full_messages }
    #     format.json { render json: @review.errors, status: :unprocessable_entity }
    #   end
    # end


  def destroy
    @review.destroy
    redirect_to business_path(@business), status: :see_other
  end

  private

  def set_business
    @business = Business.find(params[:business_id])
  end

  def review_params
    params.require(:review).permit(:title, :content, :job_title, :rating, :wage, :votes, :recommended)
  end
end
