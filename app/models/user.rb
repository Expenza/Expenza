class User < ActiveRecord::Base
  has_many :receipts, :dependent => :destroy
  has_many :expense_reports, :dependent => :destroy
   belongs_to :company
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
end
