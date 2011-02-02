class ExpenseReport < ActiveRecord::Base
  has_many :expense_lines
  has_and_belongs_to_many :users
  include Canable::Ables  # Trying canable

  attr_accessible :status, :name, :amount, :user_ids

  def setup_companyadmin(creator)
    ca_role = Role.find_by_name "CompanyAdmin"

     creator.companies.each do |co|
       co.users.each do |us|
         if us.roles.include? ca_role
           self.user_ids += [us.id]
         end
       end
     end
  end

  def viewable_by?(user)
    self.users.include? user
  end

  def creatable_by?(user)
   true
  end

  def updatable_by?(user)
     self.users.include? user
  end

  def destroyable_by?(user)
    #user_role = Role.find_by_name "User"
    (updatable_by?(user)) #&& (user.roles.include?(user_role))
  end

  class << self; attr_accessor :constraint_column end
    @constraint_column = "user_ids"

    searchable do
      text :name
      text :tags
      text :comment
      integer :user_ids, :multiple => true  #, :references => User
    end

end
