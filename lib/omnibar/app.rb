#!/usr/bin/env ruby

require 'io/console'

require_relative 'ansi'
require_relative 'query'
require_relative 'renderer'

module Omnibar
  class App
    attr_accessor :input
    attr_accessor :selection

    @@queries = []

    def self.add_query(query)
      @@queries.push(query)
    end

    def initialize
      @input = ''
      @selection = 0
    end

    def run
      IO.console.raw do
        ANSI.clear_screen
        ANSI.move_cursor(0, 0)
        loop do
          render
          handle_input
        end
      end
    end

    def render
      Renderer.new(input, results, selection).render!
    end

    def handle_input(prefix = '')
      char = prefix << $stdin.getc
      case char
      when "\u0003" # ctrl-c
        quit
      when "\u007F" # backspace
        self.input = input[0..-2]
      when "\e", "\e["
        handle_input(char)
      when "\e[A"
        self.selection = [selection - 1, 0].max
      when "\e[B"
        self.selection = [selection + 1, visible_queries.count - 1].min
      when "\r"
        perform_action!
      else
        input << char
      end
    end

    def results
      return [] if input.empty?

      queries.map(&:preview_text).compact
    end

    def perform_action!
      visible_queries[selection]&.perform!
      self.input = ""
    end

    def queries
      @@queries.map { |q| q.new(input) }
    end

    def visible_queries
      queries.reject { |q| q.preview_text.nil? }
    end

    def quit
      ANSI.clear_screen
      exit 0
    end
  end
end
