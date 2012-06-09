# Duvet

Install with:

``` bash
$ gem install duvet
```

Then add this to the __very__ top of your `test/helper.rb` (or similar)

``` ruby
require 'duvet'
Duvet.start
```

Because `duvet` won't work for Ruby 1.8 you may want to rescue the error and
move on,

``` ruby
begin
  require 'duvet'
  Duvet.start
rescue LoadError
  # ignore error
end
```

You can change the defaults by passing options to `Duvet.start`, for example:

``` ruby
Duvet.start :dir => 'coverage', :filter => 'app/lib'
```

Where `:dir` is the directory to write the coverage to and `:filter` is a string
that a files path must match against. A regular expression can be used for more
control, but most of the time a simple string will suffice.

You can see the output of running `duvet` on itself [here][covg].


## Credits

This gem was created because I read this [blog post][post] on the AT&T
engineering site by Aaron Patterson.

## Copyright

Copyright (c) 2010-11 Joshua Hawxwell. See LICENSE for details.


[covg]: http://hawx.github.com/duvet/cov
[post]: http://engineering.attinteractive.com/2010/08/code-coverage-in-ruby-1-9/
