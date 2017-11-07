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
      [label, res.strip] unless res.nil? || res.empty?
    end

    def result
      input
    end

    def label
      self.class.name.split('::').last.gsub(/[A-Z]/) { |w| ' ' << w }.strip
    end

    def perform!; end

    def copy_to_clipboard(value)
      `echo "#{value}" | xsel -i --clipboard`
    end

    def open_in_browser(url)
      Thread.new { run_silently 'xdg-open', url }
    end

    def run_silently(*command)
      `#{command.join(' ')} >/dev/null 2>&1`
    end
  end
end
