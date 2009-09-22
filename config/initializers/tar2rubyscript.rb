# encoding: UTF-8
module Rails
  class Configuration
    def database_configuration
      conf = YAML::load(ERB.new(IO.read(database_configuration_file)).result)
      if defined?(TAR2RUBYSCRIPT)
        RAILS_DEFAULT_LOGGER.info("re-reading database config\n")
        conf.each do |k, v|
          if v["adapter"] =~ /^sqlite3/
            if v.include?("database")
              RAILS_DEFAULT_LOGGER.info("changing database file from #{v["database"]} to #{oldlocation(v["database"])}\n")
              v["database"] = oldlocation(v["database"])
	    end
            if v.include?("dbfile")
              RAILS_DEFAULT_LOGGER.info("changing database file from #{v["dbfile"]} to #{oldlocation(v["dbfile"])}\n")
              v["dbfile"]   = oldlocation(v["dbfile"])
	    end
          end
        end
      end
      conf
    end
  end
end

if defined?(TAR2RUBYSCRIPT)
  # Reload configuration
  Rails::Initializer.run(:initialize_database)
end
