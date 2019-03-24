class User < ActiveRecord::Base
  has_many :votes

  validates :name, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }

  serialize :data, Hash
  #OAuth tokens
  def authentication_token
    data['authentication_token']
  end

  def authentication_token= token
    data['authentication_token'] = token
  end

  def access_token
    data['access_token']
  end

  def access_token= token
    data['access_token'] = token
  end

end