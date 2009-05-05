class CapacityContract < Contract
  property :max_bid, Float

  before :create, :default_approval

  def default_approval; true; end
end
