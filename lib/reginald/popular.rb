module Reginald
  class Popular < Query
    def result
      case input
      when /^news/
        'news.ycombinator.com'
      when /^redd?i?t?/
        'reddit.com'
      when /^fac?e?b?o?o?k?/
        "[facebook] you're bad and you should feel bad"
      when /^twit?t?e?r?/
        'twitter.com'
      end
    end

    def perform!
      return if input.match?(/^fac?e?b?o?o?k?/)
      open_in_browser "https://#{result}"
    end
  end
end
