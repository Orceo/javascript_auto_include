module JavascriptAutoInclude
  class Railtie < Rails::Railtie
    initializer "javascript_auto_include.action_controller" do |app|
      require 'javascript_auto_include/helpers/action_controller'
      ActionController::Base.send(:include, JavascriptAutoInclude::Helpers::ActionController)
      ActionController::Base.send(:before_filter, :identify_controller_and_action)
    end
    
    initializer "javascript_auto_include.action_view" do |app|
      require 'javascript_auto_include/helpers/action_view'
      ActionView::Base.send(:include, JavascriptAutoInclude::Helpers::ActionView)
    end
  end
end