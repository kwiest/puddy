require 'prawn'
require 'monetizable'
require 'state_machine'

module Puddy
  class Engine < ::Rails::Engine
    isolate_namespace Puddy
  end
end
