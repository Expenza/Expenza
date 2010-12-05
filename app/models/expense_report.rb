class ExpenseReport < ActiveRecord::Base
    has_many :expense_lines, :dependent => :destroy
  belongs_to :user
end
