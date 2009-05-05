class SurveyResult
  include DataMapper::Resource
  
  property :id, Serial
  property :answer, String
  property :completed_at, DateTime
  
  belongs_to :venue
  belongs_to :inquiry
end
