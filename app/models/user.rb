class User < ApplicationRecord
  has_many :posts

  validates :username, presence: true,
                      uniqueness: { case_sensitive: false },
                      length: { in: 3..20 }

  validates :email, presence: true,
                   uniqueness: { case_sensitive: false },
                   format: { with: URI::MailTo::EMAIL_REGEXP }
end
