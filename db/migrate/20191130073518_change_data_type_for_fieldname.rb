class ChangeDataTypeForFieldname < ActiveRecord::Migration[5.0]
   def self.up
    change_table :users do |t|
      t.change :degree_plan_date,:date
      t.change :prelim_date,:date
    end
  end
  def self.down
    change_table :tablename do |t|
      t.change :degree_plan_date, :datetime
      t.change :prelim_date,:datetime
    end
  end
end
