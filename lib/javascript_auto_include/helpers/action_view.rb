module JavascriptAutoInclude
  module Helpers
    # = ActionView helpers
    # 
    # This module contains the helper +javascript_auto_include_tag+, which inserts the javascript
    # include tag(s) into a view.
    # 
    # == Basic usage
    #
    #   <%= javascript_auto_include_tag :defaults %>
    #
    # ... will insert the default javascripts (just like javascript_include_tag) and also look for an
    # action-specifc javascript file at public/javascripts/:controller/:action.js. If it exists, it will
    # be included as well.
    #
    # == Using your own pattern
    #
    #   <%= javascript_auto_include_tag :defaults, :pattern => ':controller_:action.js' %>
    #
    # ... will work just like shown above but alter the search path according to the supplied pattern:
    # public/javascripts/:controller_:action.js (e.g. public/javascripts/album_new.js)
    #
    # == Compatibility
    #
    # +javascript_auto_include_tag+ uses Rails' javascript_include_tag helper and passes on all options
    # (:concat, :cache, ...) and keys (:defaults, :all, ...) supplied
    #
    module ActionView
      
      def javascript_auto_include_tag(*sources) #:nodoc:
        options = sources.extract_options!.stringify_keys
        pattern = options.key?("pattern") ? options.delete("pattern") : ":controller#{File::SEPARATOR}:action"
        
        auto_javascript_file = pattern.sub(":controller",$CONTROLLER).sub(":action",$ACTION) + ".js"
        
        sources << auto_javascript_file if File.exists?(Rails.root.join('public','javascripts',auto_javascript_file))
        javascript_include_tag(*sources << options)
      end
      
    end
  end
end