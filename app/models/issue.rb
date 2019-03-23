class Issue < ActiveRecord::Base

  validates :title, :description, :presence => true

  KIND_OF_VOTE = ["positive", "negative"]

  def update_score vote
    send("add_#{vote}_point!") if KIND_OF_VOTE.include? vote
  end

  def add_positive_point!
    update_attribute(:positive_point, positive_point + 1)
  end

  def add_negative_point!
    update_attribute(:negative_point, negative_point + 1)
  end
end