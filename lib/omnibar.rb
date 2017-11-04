# coding: utf-8
require 'dry-configurable'
require 'fuzzy_match'
require 'amatch'

require 'omnibar/version'
require 'omnibar/app'

require 'omnibar/calculate'
require 'omnibar/emoji'
require 'omnibar/spell'
require 'omnibar/system'
require 'omnibar/snippet'
require 'omnibar/github'
require 'omnibar/popular'
require 'omnibar/duck_duck_go'
require 'omnibar/google'

module Omnibar
  extend Dry::Configurable

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
    setting :after_perform, -> {}
  end

  def self.load_config
    load File.expand_path('~/.omnibar')
  rescue LoadError => _
  end
end

FuzzyMatch.engine = :amatch
