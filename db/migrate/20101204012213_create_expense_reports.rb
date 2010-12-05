class CreateExpenseReports < ActiveRecord::Migration
  def self.up
    create_table :expense_reports do |t|
      t.integer :status
      t.string :name
      t.integer :amount
      t.integer :user_id
      t.integer :approver_id

      t.timestamps
    end
  end

  def self.down
    drop_table :expense_reports
  end
end
