# Omnibar

[![Gem Version](https://badge.fury.io/rb/omnibar.svg)](https://badge.fury.io/rb/omnibar)
[![Maintainability](https://api.codeclimate.com/v1/badges/986aa321241fbeb4a9e1/maintainability)](https://codeclimate.com/github/shreve/omnibar/maintainability)

Omnibar is a tool for quick access to multiple scripts and searches.


## Installation

Install as:

    $ gem install omnibar

## Usage

Run `omnibar` and start typing. Use the arrow keys to select the result you like, and press enter to go!

Read about an optimal omnibar setup in the wiki: [Omnibar & i3](https://github.com/shreve/omnibar/wiki/Omnibar-&-i3)

## Queries

Omnibar is powered by queries. These are the built-in ones:

| Name | Description |
|------|-------------|
| Calculate | Evaluate math expressions (powered by Math module) |
| Emoji | Search for emojis by name |
| Spell | Fuzzy search for the correct spelling of a word |
| System | Run system commands like sleep, reboot, and shutdown |
| Snippet | Access named user-provided snippets |
| GitHub | Access user-provided GitHub repos, or quick open a repo |
| Popular | Access user-provided popular websites |
| DuckDuckGo | Search via Duck Duck Go |
| Google | Search via Google |

## Configuration

Omnibar looks at the file `~/.omnibar` to configure the app. This file is executed as ruby.

```ruby
#!/usr/bin/env ruby

Omnibar.configure do |omnibar|
  omnibar.key = "value"
end
```

| Config Key | Type | Default |
|------------|------|---------|
| github.repos | Array | `[]` |
| render.prompt | Lambda / String | `->(width) { ('-' * width) << '>' }` |
| render.highlight.fg | Symbol | `:black` |
| render.highlight.bg | Symbol | `:yellow` |
| events.after_perform | Lambda | `-> {}` |

Create your own queries by adding the code to your config file. Your class simply needs to extend from `Omnibar::Query`

```ruby
class MyQuery < Omnibar::Query
  def result
    # The string that should be displayed inside the preview
    # If this is null, the query won't be included

    input # The current input value
  end

  def perform!
    # Execute the query

    copy_to_clipboard input
    open_in_browser "https://#{input}"
  end
end
```

## OS Limitations

This gem has been developed on Ubuntu, and should work on most linux distributions.
All the code is in ruby, but there are several dependencies that are linux-only.

| Library | Usage |
|---------|-------|
| xdg-open | Opening urls and files |
| GNU aspell | Spell checking and suggestions |

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/shreve/omnibar.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
