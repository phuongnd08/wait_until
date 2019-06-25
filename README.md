wait_until
==========

Suspends execution until state changes via ```::Wait.until!``` methods.

An alternative to the ```wait``` gem with a focus on readability via:

* Requiring a description of the state change being observed, which is included in any raised timeout exception:

```ruby
    Wait.until_true! { service.started? }
```

* Providing alternate ```until``` methods:

```ruby
   Wait.until! { foo.re_try! }
   Wait.until_true! { foo.truthy? }
   Wait.until_false! { foo.falsey? }
```

* Optionally allowing a timeout per ```until``` method call:

```ruby
   Wait.until!(timeout_in_seconds: 10) { foo.re_try! }
```

* Optionally allowing a description of the operation being polled, which is included in the failure message:

```ruby
   Wait.until!(description: "an exception does not occur") { foo.re_try! }
```

* Optionally allowing explicit provision of the failure message when a timeout occurs:

```ruby
   Wait.until!(failure_message: "retry attempts were unsuccessful") { foo.re_try! }
```

* Optionally performing diagnostics when a timeout occurs:

```ruby
   Wait.until!(on_failure: lambda { logger.log(resource.contents) }) { resource.contains?("foo") }
```

Status
------

[![Build Status](https://travis-ci.org/MYOB-Technology/wait_until.png)](https://travis-ci.org/MYOB-Technology/wait_until)
[![Gem Version](https://badge.fury.io/rb/wait_until.png)](http://badge.fury.io/rb/wait_until)
[![Code Climate](https://codeclimate.com/github/MYOB-Technology/wait_until/badges/gpa.svg)](https://codeclimate.com/github/MYOB-Technology/wait_until)
[![Test Coverage](https://codeclimate.com/github/MYOB-Technology/wait_until/badges/coverage.svg)](https://codeclimate.com/github/MYOB-Technology/wait_until/coverage)

Usage
-----

* ```gem install wait_until```

```ruby
    require 'wait_until'

    ::Wait.default_timeout_in_seconds = 5
```

Requirements
------------

* >= Ruby 2.3
* JRuby is supported
