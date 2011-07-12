module JavascriptAutoInclude
  module Helpers
    # = ActionView helpers
    # 
    # This module contains the helpers +javascript_auto_include_tag+ and +javascript_auto_include+. Both provide convenient automatisms
    # for including javascript source tags in yoru views.
    #
    # == Basic usage
    #
    # See helpers below for instructions
    #
    # == Compatibility
    #
    # Both helpers use Rails' javascript_include_tag helper and pass on all options
    # (:concat, :cache, ...) and keys (:defaults, :all, ...) supplied
    #
    module ActionView
      # = javascript_auto_include_tag
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
      def javascript_auto_include_tag(*sources)
        options = sources.extract_options!.stringify_keys
        pattern = options.key?("pattern") ? options.delete("pattern") : ":controller/:action"
        
        auto_javascript_file = pattern.sub(":controller",$CONTROLLER).sub(":action",$ACTION) + ".js"
        
        sources << auto_javascript_file if File.exists?(Rails.root.join('app','assets','javascripts',auto_javascript_file))
        javascript_include_tag(*sources << options)
      end
      # = javascript_auto_include_tag
      #
      # == Basic usage
      #
      #   <%= javascript_auto_include :defaults %>
      #
      # ... will insert the default javascripts (just like javascript_include_tag) and also look for an
      # action-specifc javascript file at public/javascripts/:controller/:action.js. If it exists, it will
      # be included as well.
      #
      # In addition to what +javascript_auto_include_tag+ does it will also scan the sourc files' header and include those
      # files name there as well. For that to happen your js-file's header should look something like this:
      # /*
      # * [...]
      # *
      # * Depends:
      # *	 jquery.ui.core.js
      # *  jquery.ui.mouse.js
      # *  jquery.ui.widget.js
      # */
      #
      # For erformance reasons all dependencies identified will be stored in the config/dependencies directory of your ::Rails.root.
      # In production environments +javascript_auto_include+ will automatically pick minified versions if they exist (e.g. use
      # jquery.ui.core.min.js instead of jquery.ui.core.js)
      #
      # == Using your own pattern
      #
      #   <%= javascript_auto_include :defaults, :pattern => ':controller_:action.js' %>
      #
      # ... will work just like shown above but alter the search path according to the supplied pattern:
      # public/javascripts/:controller_:action.js (e.g. public/javascripts/album_new.js)
      #
      # == Forcing re-scan
      #
      #   <%= javascript_auto_include :defaults, :force => true %>
      #
      # ... will force +javascript_auto_include+ to parse the javascript headers again even if dependencies exists in
      # config/depdencies/jquery.ui.core.yml)
      #
      def javascript_auto_include(*sources) #:nodoc:
        options = sources.extract_options!.stringify_keys
        pattern = options.key?("pattern") ? options.delete("pattern") : ":controller/:action"
        force = options.key?("force") ? options.delete("force") : false
        
        source = SourceFile.new(expand_javascript_sources(sources << pattern.sub(":controller",$CONTROLLER).sub(":action",$ACTION)))
        sources = source.dependencies(force)
        
        javascript_include_tag(*sources << options)
      end  
    end
  end
end