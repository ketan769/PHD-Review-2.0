class AddFieldname2ToTablename < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :decision_let, :bytea
  end
end
