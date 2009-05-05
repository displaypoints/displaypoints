class Upload
  include DataMapper::Resource

  property :id,           Serial
  property :type,         Discriminator
  property :content_type, String, :nullable => false, :lenght => 32
  property :digest,       String, :nullable => false, :length => 32
  property :extname,      String, :nullable => false, :length => 10

  validates_present :content_type, :digest, :extname

  attr_accessor :data

  before :save, :write_to_bucket

  def filename
    "#{digest}#{extname}"
  end

  def path
    @path ||= unless digest.nil? || extname.nil?
      UploadManager.bucketize(Merb.dir_for(:uploads) - Merb.dir_for(:public), filename)
    end
  end

  def full_path
    @full_path ||= unless digest.nil? || extname.nil?
      UploadManager.bucketize(Merb.dir_for(:uploads), filename)
    end
  end

  def data=(data)
    self.content_type = data[:content_type] || "application/x-unknown"
    self.extname = UploadManager.resolve_extname(self.content_type, data[:filename])
    self.digest = UploadManager.calculate_digest(data[:tempfile])

    @data = data
  end

  def write_to_bucket
    UploadManager.store_file(Merb.dir_for(:uploads), self.filename, @data[:tempfile]) unless @data.nil?
  end
end
