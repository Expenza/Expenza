class Receipt < ActiveRecord::Base
    belongs_to :user
  belongs_to :expense_line
end
