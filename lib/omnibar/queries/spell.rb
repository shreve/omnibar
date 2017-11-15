require 'ffi/aspell'

module Omnibar
  class Spell < Query
    def result
      return unless using_keyword?

      words = input.split(' ')
      return ' ' if words.length == 1
      speller.suggestions(words.last).first
    end

    def self.speller
      @sp ||= FFI::Aspell::Speller.new('en_US')
    end

    def speller
      self.class.speller
    end

    def perform!
      copy_to_clipboard result
    end

    def using_keyword?
      input.match?(/^spe?l?l?/)
    end

    def relevance
      return 1 if using_keyword?
      0
    end
  end
end
