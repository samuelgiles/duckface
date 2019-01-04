0.0.4

  * Add support for checking Dry::Struct's against an interface

0.0.3

  * `Class.check_it_implements` now returns a `CheckSession`.
  * RSpec shared example takes advantage of `CheckSession` to be able to present a list of reasons why your implementation sucks.

0.0.2

  * Add `Class.says_it_implements?` for quickly checking whether a class says it is implementing a given interface. This doesn't perform the full method/params checking that happens on `.check_it_implements`.
  * Make `.check_it_implements` available on any class

0.0.1

  * Initial release
