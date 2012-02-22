begin
  require 'skyline'
rescue LoadError
  require File.dirname(__FILE__) + "/../../vendor/plugins/skyline/lib/skyline"
end

import Skyline.root + "lib/tasks/implementation.rake"