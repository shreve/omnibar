module Omnibar
  class Google < Query
    def perform!
      param = input.gsub(/\s/, '+')
      open_in_browser "https://www.google.com/search?q=#{param}"
    end
  end
end
