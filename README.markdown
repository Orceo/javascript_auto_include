# Automatically include controller/action-specific javascript files

`javascript_auto_include` provides basic helper methods for automatically including javascript files into your Rails 3 templates, based on a controller/action pattern. I found this to be a convenient way of avoiding countless content_fors in your views when trying to keep your javascripts unobtrusive.

## Install

Should be as easy as:

    $ gem install javascript_auto_include
  
Or in your Gemfile:

    $ gem 'javascript_auto_include' 

## Usage

### javascript_auto_include_tag

#### Basic

    <%= javascript_auto_include_tag :defaults %>
  
... will insert the default javascripts (just like `javascript_include_tag`) and also look for an action-specifc javascript file at public/javascripts/:controller/:action.js. If it exists, it will be included as well.

#### Custom pattern

    <%= javascript_auto_include_tag :defaults, :pattern => ':controller_:action.js' %>

... will work just like shown above but alter the search path according to the supplied pattern: public/javascripts/:controller_:action.js (e.g. public/javascripts/album_new.js)

### javascript_auto_include

#### Basic

    <%= javascript_auto_include :defaults %>

... will insert the default javascripts (just like `javascript_include_tag`) and also look for an action-specifc javascript file at public/javascripts/:controller/:action.js. If it exists, it will be included as well.

In addition to what +javascript_auto_include_tag+ does it will also scan the sourc files' header and include those files name there as well. For that to happen your js-file's header should look something like this:

    /*
     * [...]
     *
     * Depends:
     *	 jquery.ui.core.js
     *  jquery.ui.mouse.js
     *  jquery.ui.widget.js
     */

For erformance reasons all dependencies identified will be stored in the config/dependencies directory of your ::Rails.root. In production environments `javascript_auto_include` will automatically pick minified versions if they exist (e.g. use jquery.ui.core.min.js instead of jquery.ui.core.js)

#### Custom pattern

    <%= javascript_auto_include :defaults, :pattern => ':controller_:action.js' %>

... will work just like shown above but alter the search path according to the supplied pattern: public/javascripts/:controller_:action.js (e.g. public/javascripts/album_new.js)

#### Forcing re-scan

    <%= javascript_auto_include :defaults, :force => true %>

... will force +javascript_auto_include+ to parse the javascript headers again even if dependencies exists in config/depdencies/jquery.ui.core.yml)

## Compatibility

Both use Rails' `javascript_include_tag` helper and pass on all options (:concat, :cache, ...) and keys (:defaults, :all, ...) supplied.

## TODO

Right now it does what I want it to. But you decide. Go fork! 

## Copyright

Copyright (c) 2011 Ulf Möhring <hello@ulfmoehring.net>. See LICENSE.txt for further details.