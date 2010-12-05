class Category < ActiveRecord::Base
  belongs_to :expense_line
end