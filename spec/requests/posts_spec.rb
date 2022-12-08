require "rails_helper"

RSpec.describe "/posts", type: :request do
  let(:valid_attributes) do
    {
      title: "My dog ate a mouse",
      body: "OMG it was so gross",
      ip: "292.77.54"
    }
  end

  let(:invalid_attributes) do
    {
      body: "OMG it was so gross",
      ip: "292.77.54"
    }
  end

  let(:user) do
    {
      login: "Ashley"
    }
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new post" do
        expect do
          post posts_url,
               params: { post: valid_attributes, user: user }, as: :json
        end.to change(Post, :count).by(1)
      end

      it "renders a JSON response with the new post" do
        post posts_url,
             params: { post: valid_attributes, user: user }, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new post" do
        expect do
          post posts_url,
               params: { post: invalid_attributes, user: user }, as: :json
        end.to change(Post, :count).by(0)
      end

      it "renders a JSON response with errors for the new post" do
        post posts_url,
             params: { post: invalid_attributes, user: user }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end
end
