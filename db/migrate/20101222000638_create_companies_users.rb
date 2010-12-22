class CreateCompaniesUsers < ActiveRecord::Migration
  def self.up
    create_table :companies_users, :id => false do |t|
      t.references :company, :user
    end
  end

  def self.down
    drop_table :companies_users
    end
end
