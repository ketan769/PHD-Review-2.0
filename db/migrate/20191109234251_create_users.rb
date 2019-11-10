class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.integer :uin
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.string :major
      t.string :degree
      t.timestamps
    end
  end
end
