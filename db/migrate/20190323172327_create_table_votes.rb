class CreateTableVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string        :user_email
      t.string        :kind_of_vote
      t.belongs_to    :issue, index: true
      t.timestamps
    end
  end
end
