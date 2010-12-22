class User < ActiveRecord::Base
  has_many :receipts, :dependent => :destroy
  has_many :expense_lines, :dependent => :destroy
  has_and_belongs_to_many :companies
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :expense_reports
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
end
