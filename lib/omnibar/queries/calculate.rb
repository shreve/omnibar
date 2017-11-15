module Omnibar
  class Calculate < Query
    include Math

    def result
      v = value
      [sanitized_input, v].join(' = ') if v
    rescue ZeroDivisionError
      'Division by zero is undefined'
    rescue Math::DomainError => e
      e.message
    rescue StandardError, SyntaxError => e
      nil
    end

    def value
      eval('(' + sanitized_input + ').to_f')
    end

    def perform!
      copy_to_clipboard value
    end

    def sanitized_input
      input.gsub(/(\D)\./, '\10.')
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
