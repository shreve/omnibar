module Omnibar
  class Github < Query
    def result
      repo = search.find(input)
      return repo if repo
      return input if repo_full_name?
    end

    def self.search
      @fm ||= FuzzyMatch.new(Omnibar.config.github.repos)
    end

    def perform!
      param = result.downcase.gsub(/\s/, '-')
      open_in_browser "https://github.com/#{param}"
    end

    def relevance
      if repo_full_name?
        0.75
      else
        input.levenshtein_similar(result)
      end
    end

    def repo_full_name?
      input.match?(/^[\w-]+\/[\w-]+$/)
    end
  end
end

# TODO: add task for fetching user's repos https://api.github.com/users/:username/repos
