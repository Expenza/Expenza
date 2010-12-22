class ExpenseReport < ActiveRecord::Base
  has_many :expense_lines
  has_and_belongs_to_many :users
end
