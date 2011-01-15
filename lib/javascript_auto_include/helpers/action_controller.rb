module JavascriptAutoInclude
  module Helpers
    # = ActionController helpers
    # 
    # This module makes sure that the current controller and action are available as
    # public variables and thus accessible for the view helper.
    # 
    module ActionController

      def identify_controller_and_action #:nodoc:
        $CONTROLLER = request.parameters[:controller]
        $ACTION = request.parameters[:action]
      end
      
    end
  end
end