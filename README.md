# Omnibar

[![Gem Version](https://badge.fury.io/rb/omnibar.svg)](https://badge.fury.io/rb/omnibar)
[![Maintainability](https://api.codeclimate.com/v1/badges/986aa321241fbeb4a9e1/maintainability)](https://codeclimate.com/github/shreve/omnibar/maintainability)

Omnibar is a tool for quick access to multiple scripts and searches.


## Installation

Install as:

    $ gem install omnibar

## Usage

Run `bin/omnibar` and start typing. Use the arrow keys to select the result you like, and press enter to go!

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

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/shreve/omnibar.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
