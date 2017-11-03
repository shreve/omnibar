class String
  def &(other)
    self == other[0...length]
  end
end

module Omnibar
  class Github < Query
    def repos
      %w(
      wellopp/dashboard
      wellopp/dispatch
      wellopp/magic-docs
    )
    end

    def result
      repos.each do |repo|
        user, name = repo.split('/')
        return repo if (input & repo or input & user or input & name)
      end
      nil
    end

    def perform!
      param = result.downcase.gsub(/\s/, '-')
      open_in_browser "https://github.com/#{param}"
    end
  end
end
