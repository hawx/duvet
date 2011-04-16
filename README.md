# Duvet

Install with
  
    (sudo) gem install duvet

Then add this to the __very__ top of your `test/helper.rb` (or similar)

    require 'duvet'
    Duvet.start

You can change the defaults by passing an options hash to Duvet.start, eg

    Duvet.start({:dir => 'coverage', :filter => 'app/lib'})

`:dir` is the directory to write the coverage to.
`:filter` allows you to display only coverage for files that include the string.


## Credits

This gem was created because I read this blog post http://engineering.attinteractive.com/2010/08/code-coverage-in-ruby-1-9/.

## Copyright

Copyright (c) 2010 Joshua Hawxwell. See LICENSE for details.
