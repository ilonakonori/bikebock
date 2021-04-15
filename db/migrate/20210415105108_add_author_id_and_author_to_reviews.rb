class AddAuthorIdAndAuthorToReviews < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews, :author_id, :integer
    add_column :reviews, :author, :string
  end
end
