class State
  include DataMapper::Resource

  property :id,   Serial
  property :name, String, :length => 256, :nullable => false
  property :code, String, :length => 32, :nullable => false, :unique => true

  has n, :assignments, :class_name => "StateAssignment"
  has n, :exclusions, :class_name => "StateAssignment", :included => false
  has n, :inclusions, :class_name => "StateAssignment", :included => true
  has n, :cities
  has n, :venues
  
  def children(); cities end
  
  def inc_groups
    inclusions.map{|i| i.publish_group}
  end
  
  def ex_groups
    exclusions.map{|e| e.publish_group}    
  end
end