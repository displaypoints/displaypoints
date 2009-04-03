class Period
  include DataMapper::Resource

  property :id, Serial
  property :name, String, :length => 256

end
