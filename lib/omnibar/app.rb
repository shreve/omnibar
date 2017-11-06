#!/usr/bin/env ruby

require 'io/console'

module Omnibar
  class App
    def initialize
      reset_state!
      Omnibar.load_config
      Omnibar.config.events.after_start.call(self)
    end

    def run
      IO.console.raw do
        ANSI.clear_screen
        ANSI.move_cursor(0, 0)
        loop do
          render
          handle_input
        end
      end
    end

    def render
      previous = @current_view
      @current_view = View.new(@state)
      Renderer.new(@state).render_diff(previous, @current_view)
    end

    def handle_input(prefix = '')
      char = prefix << $stdin.getc
      LOG.info "Handling: #{char.inspect}"
      case char
      when "\u0003" # ctrl-c
        quit
      when "\u007F" # backspace
        @state.backspace
      when "\e", "\e["
        handle_input(char)
      when "\e[A" # Up Arrow
        @state.select_up
      when "\e[B" # Down Arrow
        @state.select_down
      when "\e[C"
        @state.move_cursor_left
      when "\e[D"
        @state.move_cursor_right
      when "\e\e"
        reset_state!
      when "\r"
        perform_action!
        reset_state!
      else
        @state.add_to_input(char)
      end
    end

    def reset_state!
      @state = State.new
    end

    def perform_action!
      @state.current_query.perform!
      Omnibar.config.events.after_perform.call
    end

    def quit
      ANSI.clear_screen
      exit 0
    end
  end
end
