class RatingsController < ApplicationController
  def create
    rating = Rating.new(rating_params)
    ActiveRecord::Base.transaction do
      rating.save!
      post = rating.post
      post.update!(average_rating: post.ratings.average(:value))
    end

    render json: rating, include: :post, status: :created

  rescue ActiveRecord::RecordInvalid
    render json: rating.errors, status: :unprocessable_entity
  end

  def rating_params
    params.require(:rating).permit(:user_id, :post_id, :value)
  end
end
