class DeviseInvitableAddToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.string   :invitation_token, :limit => 60
      t.datetime :invitation_sent_at
      t.integer  :invitation_count
      t.integer  :invited_by_id
      t.index    :invitation_token # for invitable
      t.index    :invited_by_id
    end
    
    # And allow null encrypted_password and password_salt:
    change_column_null :users, :encrypted_password, true
  end
  
  def self.down
    remove_column :users, :invited_by_id
    remove_column :users, :invitation_count
    remove_column :users, :invitation_sent_at
    remove_column :users, :invitation_token
  end
end
