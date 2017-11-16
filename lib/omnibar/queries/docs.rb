module Omnibar
  class Docs < Query
    def result
      "Search docs for \"#{input}\"" unless input.match?(/\s/)
    end

    def perform!
      run_silently 'xdg-open', "dash://#{input}", detach: true
    end

    def relevance
      0.01
    end
  end
end
