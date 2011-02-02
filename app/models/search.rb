class Search
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :keyword, :constraint, :onclass, :result
  validates_length_of :keyword, :minimum => 1
  validates_presence_of :keyword, :constraint, :onclass

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
      puts "#{name.inspect}, #{value.inspect}"
    end
  end

  def persisted?
    false
  end

  def search
     # Assuming receiving controller_name
    clazz = @onclass.camelize.singularize.constantize
    self.constraint[:constraint_column] = clazz.constraint_column
    if clazz.methods.include?("search")
      @result = clazz.search do
        keywords self.keyword
        with(self.constraint[:constraint_column].to_sym).all_of [self.constraint[:constraint_value]]
      end
    else
      @result = nil
    end
   @result 
  end
end
