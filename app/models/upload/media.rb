class Media < Upload
  belongs_to :page

  def filename
    "#{digest}-media#{extname}"
  end
end