class CreateTableIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string    :title
      t.text      :description
      t.integer   :positive_point
      t.integer   :negative_point
      t.timestamps
    end
  end
end
