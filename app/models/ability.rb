class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    if user.role? :admin
      can :manage, :all

    elsif user.role? :company_admin
      can :manage, [Company] do |company|
        # checking that the company is not nil and the user is found. if not, then return false
        #TODO: think about the case where multiple company_admins exist for the company.
        flag = false
        if company.users.find(:all).empty? || !(company.users.find(:first, :conditions => ['id =?', user.id]).nil?) #No user yet exists for the company
          flag = true
        end
        flag
        # !(company.nil?) && !(company.users.find(:first, :conditions => ['id =?', user.id]).nil?)
      end
      can :manage, [Category] do |category|
        # checking that the category is not nil and the user is found. if not, then return false
        #TODO: multiple company admins for the company
        !(category.nil?) && !(category.company.users.find(:first, :conditions => ['id =?', user.id]).nil?)
      end
      can :manage, [ExpenseLine] do |el|
        flag = false
        user.companies.each do |co|
          if !(el.user.companies.find(:first, :conditions => ['id = ?', co.id]).nil?)
            flag = true
          end
        end
        (el.try(:user) == user) || flag
      end
      can :manage, [ExpenseReport] do |er|
        !(er.nil?) && !(er.users.find(:first, :conditions => ['id =?', user.id]).nil?)
      end
      can :manage, [Receipt] do |rec|
        flag = false
        user.companies.each do |co|
          if !(rec.user.companies.find(:first, :conditions => ['id = ?', co.id]).nil?)
            flag = true
          end
        end
        (rec.try(:user) == user) || flag
      end
      can :manage, [User] do |ur|
        flag = false
        user.companies.each do |co|
          if !(ur.companies.find(:first, :conditions => ['id = ?', co.id]).nil?)
            flag = true
          end
        end
        (ur.id == user.id) || flag
      end
      can :manage, [Role] do |rl|
        flag = false
        rl.users.each do |us|
        user.companies.each do |co|
          if !(us.companies.find(:first, :conditions => ['id = ?', co.id]).nil?)
            flag = true
          end
        end
        end
        if !(rl.users.find(:first,:conditions => ['id =?',user.id]).nil?)
          flag = flag || true
        end
        flag
      end

    elsif user.role? :approver
      can :read, [ExpenseLine, Receipt]
      can :manage, [ExpenseReport] do |er|
        !(er.nil?) && !(er.users.find(:first, :conditions => ['id =?', user.id]).nil?)
      end
    elsif user.role? :user
      can :read, [Category]
      can :read, [Company] do |co|
        !(co.users.find(:first, :conditions => ['id =?', user.id]).nil?)
      end
      can :manage, [ExpenseLine] do |el|
        el.try(:user) == user
      end
      can :manage, [ExpenseReport] do |er|
        er.try(:user) == user
      end
      can :manage, [Receipt] do |rec|
         rec.try(:user) == user
      end
    #elsif user.role? :auditor   TODO
      end
    end
  end