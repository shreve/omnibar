module Omnibar
  class Snippet < Query
    def result
      value = snippets[key]
      "#{key} :: #{value}" if (key and value)
    end

    def snippets
      Omnibar.config.snippets
    end

    def key
      search.find(input)
    end

    def relevance
      input.levenshtein_similar(key) if result
    end

    def self.search
      @fz ||= FuzzyMatch.new(Omnibar.config.snippets.keys)
    end

    def perform!
      key = search.find(input)
      copy_to_clipboard snippets[key]
    end
  end
end
