require 'launchy'

module Omnibar
  class Query
    attr_reader :input

    def initialize(input)
      @input = input.strip
    end

    def self.inherited(subclass)
      Omnibar.config.queries.push(subclass)
      super(subclass)
    end

    # TODO: Convert result to class
    # TODO: Allow multiple results per query
    def preview_text
      res = result
      name = self.class.name.split('::').last.gsub(/[A-Z]/) { |w| ' ' << w }.strip
      [name, res.strip] unless res.nil? || res.empty?
    end

    def result
      input
    end

    def perform!; end

    def copy_to_clipboard(value)
      `echo "#{value}" | xsel -i --clipboard`
    end

    def open_in_browser(url)
      Launchy.open(url)
    end
  end
end
