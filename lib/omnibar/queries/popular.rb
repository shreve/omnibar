module Omnibar
  class Popular < Query
    def result
      search.find(input)
    end

    def self.search
      @fm ||= FuzzyMatch.new(Omnibar.config.popular.sites)
    end

    def perform!
      return if input.match?(/^fac?e?b?o?o?k?/)
      open_in_browser "https://#{result}"
    end
  end
end
