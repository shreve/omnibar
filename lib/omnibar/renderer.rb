module Omnibar
  class Renderer
    def initialize(state)
      @state = state
    end

    def render(view)
      ANSI.clear_screen
      ANSI.move_cursor(0, 0)
      print view.render.join("\e[2K \r\n")
      print view.cursor_position
    end

    def render_diff(previous, current)
      return render(current) if previous.nil?

      lines = [previous.length, current.length].max
      lines.times.each do |i|
        next if previous[i] == current[i]

        ANSI.move_cursor(i, 0)
        print "\e[2K"
        print current[i]
      end

      ANSI
      print current.cursor_position
    end
  end
end
