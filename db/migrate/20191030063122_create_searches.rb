class CreateSearches < ActiveRecord::Migration[5.0]
  def change
    create_table :searches do |t|
      t.numeric :uin
      t.string :first_name
      t.string :last_name
      t.numeric :review_year
      t.timestamps
    end
  end
end
