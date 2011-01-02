class Company < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :categories
  #before_save :setup_user
  attr_accessible :user_ids, :name, :address


  def setup_user(current_user_id)
    if self.user_ids.empty?
      self.user_ids = [current_user_id]
    end
  end

end
