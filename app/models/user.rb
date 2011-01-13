class User < ActiveRecord::Base
  include Canable::Cans  # Trying canable

  has_many :receipts, :dependent => :destroy
  has_many :expense_lines, :dependent => :destroy
  has_and_belongs_to_many :companies
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :expense_reports

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  attr_accessible :role_ids, :company_ids #TODO: manage company_ids with invitable
  before_save :setup_role

  def role?(role)
    !!self.roles.find_by_name(role.to_s.camelize)
  end

  def setup_role
    if self.invited_by_id.nil?
      if self.role_ids.empty?
        self.role_ids = [2]
      end
    else
      self.role_ids = [4]
      invited_by = User.find_by_id self.invited_by_id
      self.company_ids = invited_by.companies unless invited_by.companies.empty?
    end

  end


end
