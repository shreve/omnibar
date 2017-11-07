require 'json'

# This module contains helpers for various ansi-code operations
module ANSI
  # ANSI color escape codes set the foreground and background colors.
  # Forground color is a number between 30 and 37.
  # Background color is a number between 40 and 47.
  # The ones place represents the same color for both.
  COLORS = JSON.parse(File.read(File.expand_path('../db/ansi.json', File.dirname(__FILE__)))).freeze

  def self.clear_screen
    $stdout.write "\e[2J"
  end

  def self.move_cursor(row, col)
    $stdout.write "\e[#{row + 1};#{col + 1}H"
  end

  def self.shift_cursor(rows: 0, cols: 0)
    pos = position
    row = pos[:row] + rows
    col = pos[:column] + cols
    move_cursor(row, col)
  end

  def self.color(text, fg: nil, bg: nil, res: true)
    fg = COLORS[@private.snake_to_camel(fg)] if fg
    bg = COLORS[@private.snake_to_camel(bg)] if bg
    fg = "\e[38;5;#{fg}m" if fg
    bg = "\e[48;5;#{bg}m" if bg
    "#{fg}#{bg}#{text}#{reset if res}"
  end

  def self.reset
    "\e[0m"
  end

  def self.strip(text)
    text.gsub(/\e\[[0-9,;]+\w/, '')
  end

  def self.position
    res = ''
    $stdin.raw do |stdin|
      $stdout << "\e[6n"
      $stdout.flush
      while (c = stdin.getc) != 'R'
        res << c if c
      end
    end
    m = res.match(/(?<row>\d+);(?<column>\d+)/)
    {
      row: m[:row].to_i,
      column: m[:column].to_i
    }
  end

  def self.size
    win = IO.console.winsize
    {
      height: win[0],
      width: win[1]
    }
  end

  def self.print_colors
    colors = COLORS.keys.count
    groups = COLORS.to_a.sort_by { |p| p[1] }.each_slice(colors / 3).to_a.map(&:to_h)

    groups.first.keys.length.times.each do |i|
      3.times do |j|
        name = groups[j].keys[i]
        code = groups[j][name]

        pad = ' ' * (40 - (name.length * 2))
        lpad = ' ' * (3 - code.digits.count)
        print "#{lpad}#{code} \e[38;5;#{code}m#{name}\e[0m \e[48;5;#{code}m#{name}\e[0m #{pad}"
      end
      print "\n"
    end
    true
  end

  @private = Module.new do
    def self.snake_to_camel(string)
      string.to_s.split('_').map(&:capitalize).join
    end
  end
end
