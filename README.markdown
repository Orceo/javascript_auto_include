# `javascript_auto_include`: Automatically include controller/action-specific javascript files

`javascript_auto_include` provides basic helper methods for automatically including javascript files into your Rails 3 templates, based on a controller/action pattern. I found this to be a convenient way of avoiding countless content_fors in your views when trying to keep your javascripts unobtrusive.

## Install

Should be as easy as:

  $ gem install `javascript_auto_include`
  
Or in your Gemfile:

  $ gem '`javascript_auto_include`', '~> 0.1.0'

## Usage

Put in your layout's head just like you would with javascript_include_tag

### Basic

  <%= javascript_auto_include_tag :defaults %>
  
... will insert the default javascripts (just like `javascript_include_tag`) and also look for an action-specifc javascript file at public/javascripts/:controller/:action.js. If it exists, it will be included as well.

### With custom pattern

  <%= javascript_auto_include_tag :defaults, :pattern => ':controller_:action.js' %>

... will work just like shown above but alter the search path according to the supplied pattern: public/javascripts/:controller_:action.js (e.g. public/javascripts/album_new.js)

### Compatibility

`javascript_auto_include_tag` uses Rails' `javascript_include_tag` helper and passes on all options (:concat, :cache, ...) and keys (:defaults, :all, ...) supplied.

## TODO

I just extracted this from a current project. It still lacks specs and testing but so far it seems to work for me. 

## Copyright

Copyright (c) 2011 Ulf Möhring <hello@ulfmoehring.net>. See LICENSE.txt for
further details.