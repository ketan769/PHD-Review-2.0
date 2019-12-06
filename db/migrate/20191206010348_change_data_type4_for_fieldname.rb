class ChangeDataType4ForFieldname < ActiveRecord::Migration[5.0]
  def change
      change_column(:reviews, :review_score, :string)
  end
end
