module Omnibar
  class Github < Query
    def result
      repo = search.find(input)
      return repo if repo
      return input if input.match?(/^[\w-]+\/[\w-]+$/)
    end

    def search
      @fm = FuzzyMatch.new(Omnibar.config.github.repos)
    end

    def perform!
      param = result.downcase.gsub(/\s/, '-')
      open_in_browser "https://github.com/#{param}"
    end
  end
end

# TODO: add task for fetching user's repos https://api.github.com/users/:username/repos
