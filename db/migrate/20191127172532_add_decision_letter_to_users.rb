class AddDecisionLetterToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :decision_letter, :string
  end
end
