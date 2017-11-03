module Omnibar
  # This module contains helpers for various ansi-code operations
  module ANSI
    # ANSI color escape codes set the foreground and background colors.
    # Forground color is a number between 30 and 37.
    # Background color is a number between 40 and 47.
    # The ones place represents the same color for both.
    COLORS = [:black, :red, :green, :yellow, :blue, :magenta, :cyan, 'white', nil, :white].freeze

    def self.clear_screen
      $stdout.write "\e[2J"
    end

    def self.move_cursor(row, col)
      $stdout.write "\e[#{row + 1};#{col + 1}H"
    end

    def self.color(text, fg: :white, bg: :black)
      fg = COLORS.index(fg) + 30
      bg = COLORS.index(bg) + 40
      code = "\e[#{[fg, bg].compact.join(';')}m"
      "#{code}#{text}\e[0m"
    end

    def self.reset
      "\e[0m"
    end

    def self.size
      win = IO.console.winsize
      {
        height: win[0],
        width: win[1]
      }
    end
  end
end
