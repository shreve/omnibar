# coding: utf-8
require 'dry-configurable'
require 'fuzzy_match'
require 'amatch'

require 'omnibar/version'
require 'omnibar/app'

module Omnibar
  extend Dry::Configurable

  setting :queries, []

  setting :github do
    setting :repos, []
  end

  setting :popular do
    setting :sites, []
  end

  setting :snippets, 'shrug' => '¯\_(ツ)_/¯'

  setting :render do
    setting :prompt, ->(width) { ('-' * width) << '>' }

    setting :highlight do
      setting :fg, :black
      setting :bg, :yellow
    end
  end

  setting :events do
    setting :after_start, -> {}
    setting :after_perform, -> {}
  end

  def self.load_config
    load File.expand_path('~/.omnibar')
  rescue LoadError => _
  end
end

FuzzyMatch.engine = :amatch

# Require all the queries
dir = File.join(File.dirname(File.expand_path(__FILE__)), 'omnibar/queries')
Dir["#{dir}/*.rb"].each { |file| require file }

# Move fallback queries to the end
Omnibar.config.queries << Omnibar.config.queries.delete(Omnibar::DuckDuckGo)
Omnibar.config.queries << Omnibar.config.queries.delete(Omnibar::Google)
