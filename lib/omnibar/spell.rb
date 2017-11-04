require 'ffi/aspell'

module Omnibar
  class Spell < Query
    def result
      speller.suggestions(input.split(' ').last).first if input.match?(/^spe?l?l? \w+/)
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
  end
end
