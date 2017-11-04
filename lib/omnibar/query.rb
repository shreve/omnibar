module Omnibar
  class Query

    attr_reader :input

    def initialize(input)
      @input = input
    end

    def self.inherited(subclass)
      Omnibar.config.queries.push(subclass)
      super(subclass)
    end

    def preview_text
      res = result
      name = self.class.name.split('::').last
      [name, res] unless result.nil? || result.empty?
    end

    def result
      input
    end

    def copy_to_clipboard(value)
      `echo "#{value}" | xsel -i --clipboard`
    end

    def open_in_browser(url)
      Thread.new { `xdg-open "#{url}" >/dev/null 2>&1` }
    end
  end
end
