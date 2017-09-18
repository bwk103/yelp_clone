class ReviewsController < ApplicationController

  def index
    @reviews = Review.all
  end

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.build_review(review_params, current_user)

    if @review.save
      redirect_to restaurants_path
    else
      if @review.errors[:user]
        redirect_to restaurants_path; flash[:notice] = "You have already reviewed this restaurant"
      else
        render :new
      end
    end
  end

  def destroy
    user = current_user
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.find(params[:id])

    if user.reviews.include(@review)
      @review.destroy
      flash[:notice] = "You deleted your review"
      redirect_to restaurants_path

    else
      flash[:notice] = "You can only delete your own reviews"
      redirect_to restaurants_path
    end
  end

  private

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

end
