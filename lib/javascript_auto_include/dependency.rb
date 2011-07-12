class Dependency < Array
  
  # Override inherited << method to only add existing files
  def << obj
    if File.exists?("#{::Rails.root}/public/javascripts/#{obj}") || File.exists?("#{::Rails.root}/public/javascripts/#{obj}.js")
      super(obj)
    else
      ::Rails.logger.warn "'#{obj}' wasn't found in '#{::Rails.root}/public/javascripts' but seems to be required. Your app might not work as expected."
      self
    end
  end

end