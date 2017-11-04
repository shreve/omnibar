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

  setting :render do
    setting :prompt, ->(width) { ('-' * width) << '>' }

    setting :highlight do
      setting :fg, :black
      setting :bg, :yellow
    end
  end

  setting :events do
    setting :after_perform, -> {}
  end

  def self.load_config
    load File.expand_path('~/.omnibar')
  rescue LoadError => _
  end
end
