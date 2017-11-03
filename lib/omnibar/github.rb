class String
  def &(other)
    self == other[0...length]
  end
end

module Omnibar
  class Github < Query
    def repos
      Omnibar.config.github.repos
    end

    def result
      repos.each do |repo|
        user, name = repo.split('/')
        name ||= ''
        return repo if (input & repo or input & user or input & name)
      end

      return input if input.match?(/^[\w-]+\/[\w-]+$/)
    end

    def perform!
      param = result.downcase.gsub(/\s/, '-')
      open_in_browser "https://github.com/#{param}"
    end
  end
end

# TODO: assume name/name is a github repo
# TODO: add task for fetching user's repos https://api.github.com/users/:username/repos
