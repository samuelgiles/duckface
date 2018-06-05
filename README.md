![duckface](https://user-images.githubusercontent.com/2643026/40590182-811ac3bc-61f2-11e8-814a-b235c51fd52c.jpg)

# Duckface

A collection of tools to enforce duck typing based interfaces in Ruby.

## Install

From gem:
```
gem 'duckface-interfaces', require: 'duckface'
```

From source:
```
gem 'duckface-interfaces', require: 'duckface', git: 'git@github.com:samuelgiles/duckface.git'
```

## Configure

### RSpec

`spec/spec_helper.rb`

```ruby
require 'duckface/rspec'
```

## Usage

### Define an interface

```ruby
require 'duckface'

module MyInterface
  extend Duckface::ActsAsInterface

  exclude_methods_from_interface_enforcement :ignoreable_method_a, :ignoreable_method_b

  def say_my_name(_name)
    raise NotImplementedMethod
  end

  def ignoreable_method_a
    puts 'I can be ignored'
  end

  def ignoreable_method_b
    puts 'And so can I'
  end
end
```

### Define an implementation

```ruby
require 'duckface'

class MyImplementation
  implements_interface MyInterface

  def say_my_name(name)
    puts name
  end
end
```

### Test that an implementation correctly implements an interface

```ruby
require 'spec_helper'

describe MyImplementation
  it_behaves_like 'it implements', MyInterface
end
```
