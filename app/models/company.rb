class Company < ActiveRecord::Base
  include Canable::Ables  # Trying canable

  has_and_belongs_to_many :users
  has_many :categories
  validates_uniqueness_of :name, :case_sensitive => false
  validates_presence_of :name
  before_save :setup_subdomain
  attr_accessible :user_ids, :name, :address, :subdomain


  def setup_user(current_user_id)
    if self.user_ids.empty?
      self.user_ids = [current_user_id]
    end
  end

  def setup_subdomain
    self.subdomain = self.subdomain.camelize.parameterize(sep='')
  end

  ##### For Canable #####
  def viewable_by?(user)
    user.companies.include? self
  end

  def creatable_by?(user)
    ca_role = Role.find_by_name "CompanyAdmin" #remove hardcoding later
    user.roles.include? ca_role
  end

  def updatable_by?(user)
     viewable_by?(user) && creatable_by?(user)
  end

  def destroyable_by?(user)
    updatable_by?(user)
  end

end
