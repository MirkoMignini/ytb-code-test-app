class User < ActiveRecord::Base
  has_many :books, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, email: true
end
