class RearrangeColumnInReviewModel < ActiveRecord::Migration
  def up
    change_column :reviews, :title, :string, after: :id
  end
end
