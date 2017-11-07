module Omnibar
  class Calculate < Query
    include Math

    def result
      begin
        [input, value].join(' = ')
      rescue Exception => _e
      end
    end

    def value
      eval(input + '.to_f')
    end

    def perform!
      copy_to_clipboard value
    end

    def pi
      PI
    end

    def e
      E
    end
  end
end

class Integer
  alias ^ **
end
