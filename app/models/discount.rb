class Discount
  include DataMapper::Resource

  property :id, Serial
  property :amount, Float

  belongs_to :price
  belongs_to :corporation
end
