class User < ActiveRecord::Base
  has_many :books, dependent: :destroy

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, email: true
end
