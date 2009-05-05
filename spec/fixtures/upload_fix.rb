ImageMedia.fixture {{
  :data => tmp_media_data(Dir[Merb.root / 'assets' / 'images' / '**' / '*.*'].to_a.pick)
}}

RpmMedia.fixture {{
  :data => tmp_media_data(Dir[Merb.root / 'assets' / 'rpms' / '**' / '*.rpm'].to_a.pick)
}}

def tmp_media_data(file)
  tmp = Tempfile.new(File.basename(file))
  tmp.close
  FileUtils.cp file, tmp.path
 
  type = case File.extname(file)
  when '.png' then "image/png"
  when '.jpeg', '.jpg' then "image/jpeg"
  when '.rpm' then "application/x-rpm"
  end
 
  Mash.new(:tempfile => tmp, :filename => File.basename(file), :content_type => type)
end

5.of {ImageMedia.gen}
