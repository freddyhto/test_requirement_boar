class RemovePointsFieldsFromIssues < ActiveRecord::Migration
  def change
    remove_column :issues, :positive_point, :integer
    remove_column :issues, :negative_point, :integer
  end
end
