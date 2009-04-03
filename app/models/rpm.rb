class Rpm
  include DataMapper::Resource
  property :id, Serial
  property :major_version, Integer
  property :minor_version, Integer
  property :release_name, Enum[:alpha, :beta, :final]
  property :release_code, Integer

  has 1, :rpm_media, :class_name => "RpmMedia"

  attr_accessor :media_data

  def self.find_by_name(name)
    return if name.nil? or name.strip.length == 0
    
    tokens = name.strip.split("-")
    
    return if tokens.length != 3
    
    version, release_name = tokens[1].split("_")
    major_version, minor_version = version.split(".")
    release_code = tokens[2]

    rpm = first(:major_version => major_version,
                :minor_version => minor_version,
                :release_name => release_name.to_sym,
                :release_code => release_code)

    return rpm
  end

  def self.update_available?(other)
    rpms = all(:order => [:major_version.desc])
    return false if rpms.count == 0

    return true if other.nil?

    #ugly logic for checking releases
    major_release = other.major_version < rpms[0].major_version
    point_release = other.major_version == rpms[0].major_version and other.minor_version < rpms[0].minor_version
    beta_release = other.minor_version == rpms[0].minor_version and other.release_name == :alpha and (rpms[0].release_name == :beta or rpms[0].release_name == :final)
    final_release = other.minor_version == rpms[0].minor_version and other.release_name == :beta and rpms[0].release_name == :final
    redo_release = other.release_name == rpms[0].release_name and other.release_code < rpms[0].release_code

    if major_release or point_release or beta_release or final_release or redo_release
      return true
    end

    return false
  end

  def self.get_update(other)
    rpms = all(:order => [:major_version.desc])
    if rpms.count > 0 and update_available?(other)
      return rpms[0]
    end
    
    return nil
  end

  def filename
    "displaypoints-#{major_version}.#{minor_version}_#{release_name}-#{release_code}.noarch#{rpm_media.extname}"
  end

end
