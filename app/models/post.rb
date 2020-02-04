class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories


  def categories_attributes=(category_attributes)
    category_attributes.values.each do |category_attribute|
      category = Category.find_or_create_by(category_attribute)
      self.post_categories.build(category: category)
    end
  end

end

# The category_attributes= Method was written like this in the lab web page:

# def categories_attributes=(category_attributes)
#   category_attributes.values.each do |category_attribute|
#     category = Category.find_or_create_by(category_attribute)
#     self.categories << category
#   end
# end

# We're also using a cool method called categories<<. 
# What's great about this is you can mentally think of it as two steps. 
# First, we call self.categories, which returns an array of Category objects, 
# and then we call the shovel (<<) method to add our newly found or created Category object to the array.
# We could imagine later calling save on the Post object and this then creating the post_categories join record for us. 
#In reality, this is syntactic sugar for the categories<< method. 
# That's the actual method name, and behind the scenes it will create the join record for us. 
# It's one of the methods dynamically created for us whenever we use a has_many association.
