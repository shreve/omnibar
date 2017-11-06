module Omnibar
  class Renderer
    NON_ASCII_REGEX = /[^\x00-\x7F]/.freeze

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

        if i == selection
          text = ANSI.color(text,
                            fg: Omnibar.config.render.highlight.fg,
                            bg: Omnibar.config.render.highlight.bg)
        end
        ANSI.move_cursor(i + 1, 0)
        print text
      end
      ANSI.move_cursor(0, input_line.length)
    end

    def input_line
      prompt = Omnibar.config.render.prompt
      if prompt.respond_to?(:call)
        prompt = prompt.call(max_label_length)
      end
      "#{prompt} #{input}"
    end

    def rpad(text, length = ANSI.size[:width])
      textlength = text.length + non_ascii_chars(text).length
      text + (' ' * [0, (length - textlength)].max)
    end

    def lpad(text, length = ANSI.size[:width])
      textlength = text.length + non_ascii_chars(text).length
      (' ' * [0, (length - textlength)].max) + text
    end

    def max_label_length
      @mll ||= results.map(&:first).map(&:length).max || 10
    end

    def non_ascii_chars(string)
      string.chars.select { |c| c.match?(NON_ASCII_REGEX) }
    end
  end
end
