class Post < ApplicationRecord
  belongs_to :user
  has_many :ratings

  validates :title, { presence: true }
  validates :body, { presence: true }
end
