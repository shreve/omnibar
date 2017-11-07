module Omnibar
  class Google < Query
    def label
      [
        ANSI.color('G', res: false, fg: :blue),
        ANSI.color('o', res: false, fg: :red),
        ANSI.color('o', res: false, fg: :yellow),
        ANSI.color('g', res: false, fg: :blue),
        ANSI.color('l', res: false, fg: :green),
        ANSI.color('e', res: false, fg: :red),
        ANSI.reset
      ].join
    end

    def perform!
      param = input.gsub(/\s/, '+')
      open_in_browser "https://www.google.com/search?q=#{param}"
    end
  end
end
