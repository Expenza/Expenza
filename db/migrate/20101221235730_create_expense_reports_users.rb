class CreateExpenseReportsUsers < ActiveRecord::Migration
  def self.up
    create_table :expense_reports_users, :id => false do |t|
      t.references :expense_report, :user
    end
  end

  def self.down
    drop_table :expense_reports_users
    end
end
