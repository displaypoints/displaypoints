class DescriptionTag < Tag
  #Example types: alcohol, appetizers, sports, etc...
  property :desc, String, :unique => true, :length => 256
end
