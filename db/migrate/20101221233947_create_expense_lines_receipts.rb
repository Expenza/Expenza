class CreateExpenseLinesReceipts < ActiveRecord::Migration
  def self.up
    create_table :expense_lines_receipts, :id => false do |t|
      t.references :expense_line, :receipt
    end
  end

  def self.down
    drop_table :expense_lines_receipts
    end
end

