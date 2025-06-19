class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  validates :title, presence: true, length: { in: 5..300 }
  validates :url, presence: true, format: { with: URI::regexp(%w[http https]) }
  validates :user_id, presence: true
end
