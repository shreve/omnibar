module Reginald
  class Query

    attr_reader :input

    def initialize(input)
      @input = input
    end

    def self.inherited(subclass)
      Reginald::App.add_query(subclass)
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

    def open_in_browser(url)
      Thread.new { `xdg-open "#{url}" >/dev/null 2>&1` }
    end
  end
end
