class Receipt < ActiveRecord::Base
  has_and_belongs_to_many :expense_lines
  belongs_to :user
end
