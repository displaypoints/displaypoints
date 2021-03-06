require 'fileutils'
   
class Admin < Application
  before :ensure_authenticated
  before :ensure_displaypoints

  def dash
    render
  end

  def gen_content
    FileUtils.rm_rf '/tmp/dp'
    dbase = DeployBase.first
    publisher = Publisher.new(dbase)
    publisher.build
    publisher.write_out

    redirect url(:admin_dash)
  end
end
