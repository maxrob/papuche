class User < ActiveRecord::Base
  has_many :messages
  has_many :stories
  has_many :permissions
  has_many :likes

  validates :nickname, :email, :password, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :email, uniqueness: true
  validates :nickname, uniqueness: true

end
