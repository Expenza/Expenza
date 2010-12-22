class Category < ActiveRecord::Base
  has_many :expense_lines
end