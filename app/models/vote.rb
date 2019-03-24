class Vote < ActiveRecord::Base
  belongs_to :issue
  belongs_to :user

  validates :kind_of_vote, :presence => true
  validate :already_voted?

  def already_voted?
    if Vote.where(user_id: self.user_id, issue_id: self.issue_id).count > 0
      errors.add :user_id, "user_id #{self.user_id} already voted on issue #{issue_id}"
    end
  end
end