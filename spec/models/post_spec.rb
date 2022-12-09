require "rails_helper"

RSpec.describe Post, type: :model do
  describe ".shared_ip_addresses" do
    it "returns ips with their associated logins" do
      user = User.create(login: "sam")
      user.posts.create(title: "foo", body: "foo body", ip: "22.22")
      second_user = User.create(login: "matt")
      second_user.posts.create(title: "bar", body: "bar body", ip: "22.22")

      shared_ips = Post.shared_ip_addresses

      expect(shared_ips.count).to eq(1)
      expect(shared_ips.first["22.22"].count).to eq(2)
    end
  end
end
