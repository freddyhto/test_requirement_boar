class User < ActiveRecord::Base
  has_many :votes

  validates :name, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
end