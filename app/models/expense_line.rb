class ExpenseLine < ActiveRecord::Base
    has_many :receipts, :dependent => :destroy
  has_one :category
  belongs_to :expense_report
end
