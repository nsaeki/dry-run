# dry-run
Dry run any class/module in Ruby.

This is a sample implementation to add dry run feature to existing class using Ruby 2.1 Refinements.
This code is also available in pure sub-classing implementation.

## Usage

In Gemfile:

```ruby
gem 'dry_run', github: 'nsaeki/dry_run'
```

And then:

```ruby
require 'dry_run'

class YourClass
  def your_method
    fail "Danger"
  end
end

# Overwrite methods by Ruby 2.1 (or above) Refinements
module Foo
  refine YourClass
    extend DryRun
    dry_run :your_method
  end
end

using Foo
DryRun.dry_run_state = :dry_run
YourClass.new.your_method
# Dry run with message "[DRY RUN] your_method"
```

Change dry run state:

```ruby
# Enable dry run
DryRun.dry_run_state = :dry_run

# Disable dry run (default)
DryRun.dry_run_state = nil     # or false
```

You can use this module in subclass:

```ruby
class DryRunYourClass < YourClass
  extend DryRun
  dry_run :your_method
end

DryRun.dry_run_state = :dry_run
DryRunYourClass.new.your_method
# Also dry run with message "[DRY RUN] your_method"
```

