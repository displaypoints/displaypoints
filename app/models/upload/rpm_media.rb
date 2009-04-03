class RpmMedia < Upload
  property :rpm_id,  Integer

  belongs_to :rpm

  validates_present :rpm
  
  def filename
    "#{digest}#{extname}"
  end
end
