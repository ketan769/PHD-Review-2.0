class CreateLogins < ActiveRecord::Migration[5.0]
  def change
    create_table :logins do |t|
      t.integer :username
      t.string :password
      t.string :email
      t.string :role

      t.timestamps
    end
  end
end
