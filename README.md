# AceSerializer

AceSerializer is a Ruby gem that provides a flexible and efficient way to serialize Ruby objects into JSON format using the [Panko serializer](#https://github.com/yosiat/panko_serializer) . It is designed to be lightweight and easy to use, making it suitable for various applications.

## Features

- **Customizable Serialization**: Easily define root keys for serialized items and arrays.
- **Support for Hashes and Structs**: Serialize both Hash and Struct objects seamlessly.
- **Array Serialization**: Handle collections of items with ease, including support for homogeneous collections.

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Installation](#installation)
- [Basic Usage](#basic-usage)
- [Advanced Usage](#advanced-usage)
- [Development](#development)
- [Contributing](#contributing)
- [License](#license)
- [Code of Conduct](#code-of-conduct)

## Installation

To install the gem, add it to your application's Gemfile:

```bash
bundle add ace-serializer
```

If you are not using Bundler, you can install the gem directly:

```bash
gem install ace-serializer
```

## Basic Usage

To use AceSerializer, you can create a serializer class that inherits from `AceSerializer::Base`. Here’s a simple example:

```ruby
class UserSerializer < AceSerializer::Base
  attributes :id, :name, :email
end

user = { id: 1, name: "John Doe", email: "john@example.com" }
serialized_user = UserSerializer.serialize_item(user)
puts serialized_user
```

## Advanced Usage

For more advanced serialization, you can customize the root keys for items and arrays:

```ruby
class ProductSerializer < AceSerializer::Base
  root :product
  root_array :products

  attributes :id, :name, :price

  view :item do |context, scope|
    only: {
      instance: [:title, :body, :author, :comments],
      author: [:id],
      comments: {
        instance: [:id, :author],
        author: [:name]
      }
    }
  end 


  view :shipping_item do |context, scope|
    only: {
      instance: [:title, :body, :author, :comments],
      author: [:id],
      comments: {
        instance: [:id, :author],
        author: [:name]
      }
    }
  end

  view :inventory_items do |context, scope|
    only: {
      instance: [:id, :name]
    }
  end
end

products = [{ id: 1, name: "Product A", price: 100 }, { id: 2, name: "Product B", price: 150 }]
item = products.first 

ProductSerializer.serialize_item(item)
ProductSerializer.serialize_item(item, view: :item)
ProductSerializer.serialize_item(item, view: :shipping_item)


ProductSerializer.serialize_array(products)
ProductSerializer.serialize_array(products, view: :inventory_items)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yourusername/ace-serializer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/yourusername/ace-serializer/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AceSerializer project's codebases, issue trackers, chat rooms, and mailing lists is expected to follow the [code of conduct](https://github.com/yourusername/ace-serializer/blob/main/CODE_OF_CONDUCT.md).
