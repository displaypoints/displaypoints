class UploadManager
  def self.resolve_extname(content_type, filename)
    case content_type
      when /application\/x-/  then File.extname(filename)
      when "text/plain"       then ".txt"
      else content_type.gsub(/.*\//, '.')
    end 
  end

  def self.calculate_digest(tempfile)
    begin
      tempfile.close unless tempfile.closed?
      tempfile.open
      Digest::MD5.hexdigest(tempfile.read)
    ensure
      tempfile.close
    end
  end

  def self.store_file(root_dir, filename, tempfile)
    prep_bucket_for(filename, root_dir)

    FileUtils.mv(tempfile.path, bucketize(root_dir, filename)) unless File.exists?(bucketize(root_dir, filename))
  end

  def self.prep_bucket_for(filename, root_dir)
    FileUtils.mkdir_p(File.dirname(bucketize(root_dir, filename)), :mode => 0o755)
  end

  def self.bucketize(root_dir, filename)
    filename.split(/(\w{2})(\w{2})(.*)/).inject(root_dir) {|a,b| a/b}
  end
end