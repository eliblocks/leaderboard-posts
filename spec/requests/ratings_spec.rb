require "rails_helper"

RSpec.describe "/ratings", type: :request do
  let(:sam) do
    User.create(login: "sam")
  end

  let(:post_record) do
    sam.posts.create(
      title: "My story",
      body: "Once upon a time...",
      ip: "23.44.55"
    )
  end

  let(:valid_attributes) do
    {
      user_id: sam.id,
      post_id: post_record.id,
      value: 3
    }
  end

  describe "POST /create" do
    context "the first time rating" do
      it "rates the post" do
        expect do
          post ratings_url, params: { rating: valid_attributes }, as: :json
        end.to change(post_record.ratings, :count).by(1)
      end

      it "creates an average rating" do
        post ratings_url, params: { rating: valid_attributes }, as: :json

        expect(post_record.reload.average_rating).to eq(3.0)
      end
    end

    context "when attempting to rate more than once" do
      it "renders an error" do
        post ratings_url, params: { rating: valid_attributes }, as: :json
        post ratings_url, params: { rating: valid_attributes }, as: :json

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
