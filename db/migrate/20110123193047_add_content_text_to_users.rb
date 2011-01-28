class AddContentTextToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :content_text, :string
  end

  def self.down
    remove_column :users, :content_text
  end
end
