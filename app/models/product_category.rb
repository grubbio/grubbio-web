class ProductCategory < ActiveRecord::Base
  attr_accessible :name, :description

  validates :name, :uniqueness => true
end
