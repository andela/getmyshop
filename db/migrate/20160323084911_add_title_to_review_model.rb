class AddTitleToReviewModel < ActiveRecord::Migration
  def change
    add_column :reviews, :title, :string, before: :comment
  end
end
