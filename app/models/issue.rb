class Issue < ActiveRecord::Base
  has_many :votes, dependent: :destroy
  validates :title, :description, :presence => true

  KIND_OF_VOTE = ["positive", "negative"]

  def add_vote(vote, user_id)
    if KIND_OF_VOTE.include? vote
      votes.create!(kind_of_vote: vote, user_id: user_id)
    else
      false
    end
  end

end