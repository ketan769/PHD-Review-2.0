class AddResetToAuths < ActiveRecord::Migration[5.0]
  def change
    add_column :auths, :reset_digest, :string
    add_column :auths, :reset_sent_at, :datetime
  end
end
