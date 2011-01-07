class User < ActiveRecord::Base
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

  attr_accessible :role_ids
  before_save :setup_role

  def role?(role)
    !!self.roles.find_by_name(role.to_s.camelize)
  end

  def setup_role
    if self.role_ids.empty?
      self.role_ids = [2]
    end
  end


end
