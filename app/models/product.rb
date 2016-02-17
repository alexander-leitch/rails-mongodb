class Product
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include Mongoid::Slug
  field :name, type: String, localize: true
  slug :name, history: true, localize: true
  field :price, type: Integer
  field :description, type: String, localize: true
end
