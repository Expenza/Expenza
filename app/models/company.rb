class Company < ActiveRecord::Base
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

end
