class TimeRange
  include DataMapper::Resource

  property :id, Serial
  property :start_at, Time
  property :end_at, Time

  belongs_to :venue
  belongs_to :period
end
