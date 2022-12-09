require "net/http"

USERNAME_COUNT = 100
ADDRESS_COUNT = 50
POST_COUNT = 1000
RATING_COUNT = 1200

Rating.delete_all
Post.delete_all
User.delete_all

usernames = Array.new(USERNAME_COUNT) { Faker::Internet.username }
addresses = Array.new(ADDRESS_COUNT) { Faker::Internet.ip_v4_address }

post_uri = URI("http://localhost:3000/posts")

POST_COUNT.times do
  params = {
    post: {
      title: Faker::Lorem.sentence(word_count: 3),
      body: Faker::Lorem.sentence(word_count: 12),
      ip: addresses.sample
    },
    user: {
      login: usernames.sample
    }
  }
  Net::HTTP.post post_uri, params.to_json, "Content-Type" => "application/json"
end

rating_uri = URI("http://localhost:3000/ratings")
RATING_COUNT.times do
  params = {
    rating: {
      user_id: rand(User.first.id..User.last.id),
      post_id: rand(Post.first.id..Post.last.id),
      value: rand(1..5)
    }
  }
  Net::HTTP.post rating_uri, params.to_json, "Content-Type" => "application/json"
end
