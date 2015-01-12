# deep_slice

[![Build Status](https://api.travis-ci.org/sermo/deep_slice.svg?branch=master)](https://travis-ci.org/sermo/deep_slice)

Like `Hash.slice` from ActiveSupport, but allows for slicing nested keys.

## Installation

Add this line to your application's Gemfile:

    gem 'deep_slice'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install deep_slice

## Usage

Take the following hash as an example

```ruby
h ={
  :a => 1,
  :b => { :c => 2, :d => 3, :z => -1 },
  :e => {
    :f => { :g => 4, :h => 5 }
  },
  :i => [
    {:j => 6, :k => 7},
    {:j => 8, :k => 9}
  ],
  :d => nil
}
```

Normal hash slicing works:

```ruby
h.deep_slice(:a, :d)
  => {:a => 1, :d => nil}
```

You can slice to any depth:
```ruby
h.deep_slice(:e => {:f => :g})
  => {:e => {:f => {:g => 4}}}
```

Arrays of hash keys can be specified at any depth:
```ruby
h.deep_slice(:a, :b => [:c, :d])
  => {:a => 1, :b => {:c => 2, :d => 3}}
```

Keys can be sliced out of arrays at any depth:
```ruby
h.deep_slice(:i => :k)
  => {:i => [{:k => 7}, {:k => 9}]}
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/deep_slice/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
