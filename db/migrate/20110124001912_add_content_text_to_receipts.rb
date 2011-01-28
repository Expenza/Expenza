class AddContentTextToReceipts < ActiveRecord::Migration
  def self.up
    add_column :receipts, :content_text, :string
  end

  def self.down
    remove_column :receipts, :content_text
  end
end
