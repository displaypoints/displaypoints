class Router < Asset
  validates_format :identifier, :with => /^([A-F0-9]{2}:){5}([A-F0-9]{2})$/
  validates_with_method :venue_occupied

  def venue_occupied
    unless self.venue.nil? || self.venue.router == self
      [:false, "The '#{self.venue.name}' venue already has a router"]
    else
      true
    end
  end
end
