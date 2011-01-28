class CreateReceipts < ActiveRecord::Migration
  def self.up
    create_table :receipts do |t|
      t.integer :user_id
      t.string :content_category
      t.binary :contents
      t.datetime :date
      t.integer :amount
      t.string :tags
      t.string :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :receipts
  end
end
