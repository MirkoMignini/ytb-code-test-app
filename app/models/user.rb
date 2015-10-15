class User < ActiveRecord::Base
  has_many :books

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, email: true
end
