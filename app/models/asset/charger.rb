class Charger < Asset
  validates_length :identifier, :max => 50
end
