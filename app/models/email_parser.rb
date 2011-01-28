require 'mail'
require 'mms2r'
class EmailParser
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :from_user, :tags, :contents, :comment, :date
  validates_length_of :contents, :minimum => 1

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  def parse_save_email
    if self.valid?
      begin
        u = User.find_by_email @from_user
        @contents.each do |key, value|
          value.each do |val|
            rec = Receipt.new(:user_id => u.id, :comment => @comment, :tags => @tags, :date => @date)
            att = ""
            File.open("#{val}", "rb") do |f|
              att << f.read
            end
            rec.contents = att
            rec.content_category = key
            rec.save!
          end  
        end unless u.nil?
      rescue Exception => e
        puts e.message
        puts e.backtrace.inspect
      end
    end
  end
 handle_asynchronously :parse_save_email

end