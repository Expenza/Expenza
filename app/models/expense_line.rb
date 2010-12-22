class ExpenseLine < ActiveRecord::Base
    has_and_belongs_to_many :receipts
    belongs_to :category
    belongs_to :expense_report
    belongs_to :user
end
