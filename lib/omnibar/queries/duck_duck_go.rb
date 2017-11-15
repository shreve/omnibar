module Omnibar
  class DuckDuckGo < Query
    def perform!
      param = input.gsub(/\s/, '+')
      open_in_browser "https://duckduckgo.com/?q=#{param}"
    end

    def label
      ANSI.color('Duck Duck Go', fg: :red3)
    end

    def relevance
      0.001
    end
  end
end
