module Omnibar
  class State < Struct.new(:input, :selection, :cursor_offset)
    def initialize(values = {})
      self.input = ''
      self.selection = self.cursor_offset = 0

      values.each_pair do |attr, val|
        send(:"#{attr}=", val)
      end
    end

    def add_to_input(string)
      self.input = input.insert(input.length - cursor_offset, string)
    end

    def backspace
      input.slice!(input.length - 1 - cursor_offset)
    end

    def select_up
      self.selection = [selection - 1, 0].max
    end

    def select_down
      self.selection = [selection + 1, visible_queries.count - 1].min
    end

    def move_cursor_left
      self.cursor_offset = [0, cursor_offset - 1].max
    end

    def move_cursor_right
      self.cursor_offset = [input.length, cursor_offset + 1].min
    end

    def queries
      Omnibar.config.queries.map { |q| q.new(input) }
    end

    def visible_queries
      (@qc ||= {})[input] ||= queries.reject { |q| q.preview_text.nil? }
    end

    def current_query
      visible_queries[selection] || Query.new
    end

    # TODO: Sort results based on relevance / certainty
    def results
      visible_queries.map(&:preview_text)
    end
  end
end
