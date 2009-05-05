module DataMapper::Resource
  def to_mash(options = {})
    case options
    when true
      to_mash
    when Hash, Mash
      if options.empty?
        property_keys = self.properties.map - self.class.relationships.values.map {|r| r.child_key.map}.flatten

        property_keys.inject(Mash.new) {|m, k| m.update(k.name => self.send(k.name))}
      else
        self.class.relationships.map.inject(to_mash) do |m, (n, r)|
      
          if options.has_key?(n)
            m[n] = case result = self.send(n)
              when DataMapper::Resource, DataMapper::Associations::ManyToOne::Proxy
                result.to_mash(options[n])
              when DataMapper::Collection, DataMapper::Associations::OneToMany::Proxy, DataMapper::Associations::ManyToMany::Proxy
                result.map {|r| r.to_mash(options[n])}
              end
          end
          m
        end
      end
    else
      to_mash
    end
  end
end