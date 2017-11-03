require 'dry-configurable'

require 'omnibar/version'
require 'omnibar/app'

require 'omnibar/calculate'
require 'omnibar/github'
require 'omnibar/popular'
require 'omnibar/google'
require 'omnibar/duck_duck_go'

module Omnibar
  extend Dry::Configurable

  setting :github do
    setting :repos, []
  end

  def self.load_config
    load File.expand_path('~/.omnibar')
  rescue LoadError => _
  end
end
