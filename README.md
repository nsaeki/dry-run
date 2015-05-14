# dry-run
Dry run any class/module in Ruby.

This is a sample implementation to add dry run feature to existing class using Ruby 2.1 Refinements.
This code is also used in pure sub-classing implementation.

## Usage

In Gemfile:

```
gem 'dry_run', github: 'nsaeki/dry_run'
```

And then:

```
require 'dry_run'

class YourClass
  def your_method
    fail "Danger"
  end
end

module Foo
  refine YourClass
    extend DryRun
    dry_run :your_method
  end
end
```
