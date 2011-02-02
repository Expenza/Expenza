class ExpenseLine < ActiveRecord::Base
    has_and_belongs_to_many :receipts
    belongs_to :category
    belongs_to :expense_report
    belongs_to :user
    include Canable::Ables  # Trying canable

    attr_accessible :receipt_ids, :date, :merchant, :amount, :category_id, :tags, :comment

  ##### For Canable #####
  def viewable_by?(user)
    ca_role = Role.find_by_name "CompanyAdmin"
    my_companies = self.user.companies

    #TODO: Update self user when expense line is created
    (self.user == user) || ((user.roles.include? ca_role) && (!((user.companies && my_companies).empty?)))
  end

  def creatable_by?(user)
   true
  end

  def updatable_by?(user)
     self.user == user
  end

  def destroyable_by?(user)
    updatable_by?(user)
  end

  #for search
  class << self; attr_accessor :constraint_column end
  @constraint_column = "user_id"

  searchable do
    text :merchant #, :default_boost => 2
    text :tags
    text :comment
    integer :user_id, :references => User
    date :date
  end
    
end
