# coding: utf-8
require 'dry-configurable'
require 'fuzzy_match'
require 'amatch'
require 'logger'

require_relative 'ansi'

require_relative 'omnibar/version'
require_relative 'omnibar/app'
require_relative 'omnibar/query'
require_relative 'omnibar/renderer'
require_relative 'omnibar/state'
require_relative 'omnibar/view'

module Omnibar
  extend Dry::Configurable

  setting :log, Logger.new('log/omnibar.log'), reader: true

  setting :queries, []

  setting :github do
    setting :repos, []
  end

  setting :popular do
    setting :sites, []
  end

  setting :snippets, 'shrug' => '¯\_(ツ)_/¯'

  setting :render do
    setting :prompt, ->(width) { (' ' * width) << ANSI.color('★', fg: :magenta) }

    setting :highlight do
      setting :fg, :white
      setting :bg, :grey15
    end
  end

  setting :events do
    setting :after_start, ->(app) {}
    setting :keypress, ->(state) {}
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
