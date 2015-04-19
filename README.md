# override-parens

A few gems and Ruby libraries - notably the `JSON` library that comes with Ruby - give you shorthands like the following:

```ruby
JSON('{}') == JSON.parse('{}')
```

Ruby doesn't actually let you override the method call operator - what's really going on is that the JSON library defines a method `JSON` on Kernel, and Ruby tolerates methods that have the same name as a class or module.

This gem lets you hide that piece of trickery and pretend that it's possible to override parentheses in Ruby.

```ruby
require 'override_parens'

class MyClass
  include OverrideParens

  def self.parens(foo)
    new(foo)
  end

  def initialize(foo)
    @foo = foo
  end
end

MyClass(1) # => #<MyClass:0xXXXX @foo=1>
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'override-parens'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install override-parens

## Dependencies

`override-parens` only works on **Ruby 1.9.3** and above.

## Contributing

1. Fork it ( https://github.com/benchristel/override-parens/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
