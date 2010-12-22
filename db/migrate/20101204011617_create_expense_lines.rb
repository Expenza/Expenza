class CreateExpenseLines < ActiveRecord::Migration
  def self.up
    create_table :expense_lines do |t|
      t.datetime :date
      t.string :merchant
      t.integer :amount
      t.string :tags
      t.string :comment
      t.integer :category_id
      t.integer :expense_report_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :expense_lines
  end
end
