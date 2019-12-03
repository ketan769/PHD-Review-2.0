class AddReviewReleaseDateToReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :decision_letter, :string
    add_column :reviews, :review_release_date, :datetime
  end
end
