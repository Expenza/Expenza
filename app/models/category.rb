class Category < ActiveRecord::Base
  has_many :expense_lines
  belongs_to :company
end