# Pundit::Cache

[![Gem](https://img.shields.io/gem/v/pundit-cache.svg)](https://rubygems.org/gems/pundit-cache)[![Travis (.org)](https://img.shields.io/travis/empaticoorg/pundit-cache.svg)](https://travis-ci.org/EmpaticoOrg/pundit-cache)

Caches your pundit policy results in local memory during a single request. This is useful when your
policy checks involve queries and may run against multiple copies of the same record during a
response.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pundit-cache'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pundit-cache

## Usage

Add to your policy classes:

```ruby
class ApplicationPolicy
  extend Pundit::Cache
end
```

Then target the policy methods you wish to cache:

```ruby
class MyPolicy < ApplicationPolicy
  def view?
    user && record && record.owner == user
  end
  cache :view?
end
```

Note that you may need to provide a `record` alias to your policy's object:

```ruby
class PostPolicy < ApplicationPolicy
  alias_method :record, :post

  def view?
    user && post && post.poster == user
  end
  cache :view?
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/empaticoorg/pundit-cache. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Pundit::Cache project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/empaticoorg/pundit-cache/blob/master/CODE_OF_CONDUCT.md).
