class Issue < ActiveRecord::Base
  has_many :votes, dependent: :destroy
  validates :title, :description, :presence => true

  KIND_OF_VOTE = {positive: "positive", negative: "negative"}

  def add_vote(vote, user_id)
    if KIND_OF_VOTE.values.include? vote
      votes.create!(kind_of_vote: vote, user_id: user_id)
    else
      false
    end
  end

  def self.issues_and_votes
    issues = Issue.all.select([:id, :title, :description])
    res = issues.map do |issue|
      {id:           issue.id,
       title:        issue.title,
       description:  issue.description,
       positive_votes: issue.votes.where(kind_of_vote: KIND_OF_VOTE[:positive]).count,
       negative_votes: issue.votes.where(kind_of_vote: KIND_OF_VOTE[:negative]).count
      }
    end
  end

end