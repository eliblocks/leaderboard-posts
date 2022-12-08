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

  let(:user_attributes) do
    {
      login: "Ashley"
    }
  end

  describe "GET /" do
    it "returns the top rated posts" do
      second_post = { title: "my life", body: "once upon a time", ip: "232.11.21", average_rating: 4.0 }
      user = User.create(user_attributes)
      user.posts.create(valid_attributes)
      user.posts.create(second_post)

      get posts_url(limit: 1)

      expect(response.status).to eq 200

      expect(response_body.count).to eq(1)
      expect(response_body[0]["title"]).to eq("my life")
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new post" do
        expect do
          post posts_url,
               params: { post: valid_attributes, user: user_attributes }, as: :json
        end.to change(Post, :count).by(1)
      end

      it "renders a JSON response with the new post" do
        post posts_url,
             params: { post: valid_attributes, user: user_attributes }, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new post" do
        expect do
          post posts_url,
               params: { post: invalid_attributes, user: user_attributes }, as: :json
        end.to change(Post, :count).by(0)
      end

      it "renders a JSON response with errors for the new post" do
        post posts_url,
             params: { post: invalid_attributes, user: user_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  def response_body
    JSON.parse(response.body)
  end
end
