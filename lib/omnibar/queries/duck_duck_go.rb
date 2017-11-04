module Omnibar
  class DuckDuckGo < Query
    def perform!
      param = input.gsub(/\s/, '+')
      open_in_browser "https://duckduckgo.com/?q=#{param}"
    end
  end
end
