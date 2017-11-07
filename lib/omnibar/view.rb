module Omnibar
  class View
    NON_ASCII_REGEX = /[^\x00-\x7F]/.freeze

    def initialize(state)
      @state = state
    end

    def [](line)
      render[line]
    end

    def length
      render.length
    end

    def render
      @render ||= [
        input_line,
        *rendered_queries
      ]
    end

    def input_line
      prompt = Omnibar.config.render.prompt
      prompt = prompt.call(max_label_length) if prompt.respond_to?(:call)
      "#{prompt} #{@state.input}"
    end

    def cursor_position
      "\e[0;#{max_label_length + @state.input.length + 3 - @state.cursor_offset}H"
    end

    def rendered_queries
      @state.results.map.with_index do |result, i|
        text = [
          lpad(result.first, max_label_length),
          rpad(result.last, ANSI.size[:width] - max_label_length - 2)
        ]

        if i == @state.selection
          text.map { |t| highlight(t) }.join(highlight(': '))
        else
          text.join(': ')
        end
      end
    end

    def highlight(text)
      ANSI.color(text,
                 fg: Omnibar.config.render.highlight.fg,
                 bg: Omnibar.config.render.highlight.bg)
    end

    def rpad(text, length = ANSI.size[:width])
      textlength = ANSI.strip(text).length + non_ascii_chars(text).length
      text + (' ' * [0, (length - textlength)].max)
    end

    def lpad(text, length = ANSI.size[:width])
      textlength = ANSI.strip(text).length + non_ascii_chars(text).length
      (' ' * [0, (length - textlength)].max) + text
    end

    def max_label_length
      @mll ||= (@state.results.map(&:first).map { |s| ANSI.strip(s) }.map(&:length).max || 0) + 1
    end

    def non_ascii_chars(string)
      string.chars.select { |c| c.match?(NON_ASCII_REGEX) }
    end
  end
end
