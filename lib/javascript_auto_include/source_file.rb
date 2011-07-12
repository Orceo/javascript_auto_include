require 'yaml'

class SourceFile
  
  # Retrieve javascript file as full path
  def initialize(files)  
    Dir.mkdir("#{::Rails.root}/config/dependencies") unless Dir.exists?("#{::Rails.root}/config/dependencies")
    @config_files = files.collect { |file| [file, "#{::Rails.root}/config/dependencies/#{file}.yml"] }
    @source_files = files.collect { |file| [file, "#{::Rails.root}/public/javascripts/#{file}#{file.match(/\.js$/) ? '' : '.js' }"] }
    @dependencies = Dependency.new
  end
  
  # Read dependencies from config file or scan source file
  def dependencies(force = false)
    0.upto(@source_files.size-1) do |i|
      if force || !config_exists?(i)
        @dependencies += read_from_source(@source_files[i], @config_files[i]) if File.exists?(@source_files[i][1])
      else
        @dependencies += read_from_config(@config_files[i])
      end
    end
    ENV["RAILS_ENV"] == 'production' ? minify(@dependencies.uniq) : @dependencies.uniq
  end
  
  private
    # Checks whether config file exists
    def config_exists?(index)
      File.exists?(@config_files[index][1])
    end
    
    # Read previously identified dependencies from cache
    def read_from_config(config)
      YAML.load_file(config[1]).to_a << config[0]
    end
    
    # Scan comment section of a javascript source file for dependencies and save result in config file
    def read_from_source(source, config)
      start = false
      dependencies = []
      File.open(source[1],'r') do |source_file|
        while (line = source_file.gets)
          break if line.match(/^ \*\//)
          dependencies << line.match(/^ \*[\t ](.*\.js)/).captures.first if start && line.match(/^ \*[\t ].*\.js/)
          start = true if line.match(/^ \* Depends:/)
        end
      end
      File.open(config[1],'w') do |config_file|
        YAML.dump(dependencies.to_a, config_file)
      end
      return dependencies << source[0]
    end
    
    # Looks for minified file versions
    def minify(sources)
      sources.each do |source|
        minified_version = source.match(/\.js$/) ? source.gsub('.js','.min.js') : "#{source}.min.js"
        sources[sources.index(source)] = (File.exists?("#{::Rails.root}/public/javascripts/#{minified_version}") ? minified_version : source)
      end
      return sources
    end
end