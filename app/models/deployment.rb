class VenueContent
  #NOT A DATAMAPPER CLASS ... so don't include DataMapper::Resource
  def initialize(publish_path, venue_id)
    @menu = nil
    #@campaigns = []
    @contracts = []
    @publish_path = publish_path
    @venue_id = venue_id
  end

  def menu=(menu)
    @menu = menu
  end

  def add_contract(contract)
    @contracts << contract
  end

  def manifest
    json = {}
    json = @menu.json_data(@publish_path) if @menu

    content_item_json = []

    @contracts.each do |contract|
      content_item_json << contract.campaign.serialize(@publish_path, contract)
    end

    json['content_items'] = content_item_json
    {'manifest' => [json]}
  end

  def filelist
    files = @menu.filelist
    @contracts.each do |contract|
      files += contract.campaign.filelist
    end
    files.uniq
  end

  def content_items
    items = []
    @contracts.each do |contract|
      items += contract.campaign.content_items
    end
    
    return items
  end
  
  def sha1_digest
    Digest::SHA1.hexdigest(self.manifest.to_json) 
  end

  def ==(other)
    self.sha1_digest == other.sha1_digest
  end
end

class Publisher
  #NOT A DATAMAPPER CLASS ... so don't include DataMapper::Resource
  def initialize(base_deployment)
    @base = base_deployment
    @build_status = false
    @all_content = {}
  end

#  def find_menus(menu)
#    menus = []
#    menu.targets.each do |t|
#      self.find_menus(t.menu) unless t.menu.nil?
#    end
#    menus.push(menu)
#  end

  def write_out
    @all_content.each do |venue_id, venue_content|
      manifest_dir = "#{@base.deploy_path}" / "#{venue_content.sha1_digest}"
      venue_dir = "#{@base.deploy_path}" / "#{Venue.get!(venue_id).router.identifier}"
      manifest_file = manifest_dir / "manifest.json"
      files_dir = manifest_dir / "files"
      venue_content_ln = "#{venue_dir}" / "content"
      sha1_file = manifest_dir / "#{venue_content.sha1_digest}.sha1"
  
      FileUtils.rm(venue_content_ln) if File.exists?(venue_content_ln)
      FileUtils.mkdir_p(venue_dir)
      if File.exists?(sha1_file)
        FileUtils.ln_sf(manifest_dir, venue_content_ln)
        next
      end

      FileUtils.mkdir_p(manifest_dir)

      open(manifest_file, "w+") do |f|
        f << venue_content.manifest.to_json
      end

      #FileUtils.mkdir_p(files_dir)
      source_files = venue_content.filelist
      venue_content.filelist.each do |f|
        #UploadManager is using the first 2 bytes of the file digest as directory names.
        #The split('/'[-3..-1].join('') restores the filename to the full digest when it is copied
        #from the upload dir to the deployment dir
        dest = "#{manifest_dir}" / "#{f.split('/')[-3..-1].join('')}"
        FileUtils.cp(f, dest)
      end
    
      open(sha1_file, "w+") do |f|
        f << venue_content.sha1_digest
      end
      
      FileUtils.ln_sf(manifest_dir, venue_content_ln)
    end
  end

  def build_venue(venue)
    venue_content = VenueContent.new(@base.deploy_path, venue.id)
    venue_content.menu = @base.menu

    venue_content.add_contract(@base.contract)
    Contract.all_active.each do | contract |
      if contract.campaign
        venue_content.add_contract(contract) if contract.campaign.venues.include? venue
      end
    end

    venue_content
  end

  def build
    Venue.all_active.each do |v|
      @all_content[v.id] = self.build_venue(v)
    end
    @build_status = true
  end

  def filelists
    fl = []
    @all_content.each do |k,v|
      fl << v.filelist
    end
    return fl
  end

  def build_complete?
    @build_status
  end
end
