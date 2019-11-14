class CreateAuths < ActiveRecord::Migration[5.0]
  def change
    create_table :auths do |t|
      t.string :username
      t.string :password_digest
      t.string :email
      t.string :role

      t.timestamps
    end
  end
end
