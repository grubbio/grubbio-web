class ProductCategory < ActiveRecord::Base
  attr_accessible :name, :description

  has_many :food_products

  validates :name, :uniqueness => true
end
