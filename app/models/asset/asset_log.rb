class AssetLog 
  include DataMapper::Resource
  
  property :id, Serial
  property :created_at, DateTime

  belongs_to :asset
  belongs_to :venue
end
