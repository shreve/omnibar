module Omnibar
  class Renderer
    attr_reader :input, :results, :selection

    def initialize(input, results, selection)
      @input = input
      @results = results
      @selection = selection
    end

    def render!
      ANSI.clear_screen
      ANSI.move_cursor(0, 0)
      puts input_line
      ANSI.move_cursor(1, 0)
      results.each.with_index do |result, i|
        text = [
          lpad(result.first, max_label_length),
          rpad(result.last, ANSI.size[:width] - max_label_length - 2)
        ].join(': ')

        text = ANSI.color(text, fg: :black, bg: :yellow) if i == selection
        print "#{text}\r\n"
      end
      ANSI.move_cursor(0, input_line.length)
    end

    def input_line
      ('-' * max_label_length) << '> ' << input
    end

    def rpad(text, length = ANSI.size[:width])
      text + (' ' * [0, (length - text.length)].max)
    end

    def lpad(text, length = ANSI.size[:width])
      (' ' * [0, (length - text.length)].max) + text
    end

    def max_label_length
      @mll ||= results.map(&:first).map(&:length).max || 10
    end
  end
end
