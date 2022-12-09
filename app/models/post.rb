class Post < ApplicationRecord
  belongs_to :user
  has_many :ratings, dependent: :destroy

  validates :title, { presence: true }
  validates :body, { presence: true }

  def self.shared_ip_addresses
    query = "SELECT
              posts.ip,
              array_agg(users.login)
            FROM posts
            INNER JOIN users ON posts.user_id = users.id
            GROUP BY posts.ip
            LIMIT 20"

    rows = ActiveRecord::Base.connection.exec_query(query).cast_values

    rows.map { |row| { row[0] => row[1] } }
  end
end
