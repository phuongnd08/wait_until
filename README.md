wait_until
============

Suspends execution until state changes via ```::Wait.until!``` methods.

An alternative to the ```wait``` gem with a focus on readability via:

* Requiring a description of the state change being observed, which is included in any raised timeout exception:

```ruby
    Wait.until_true!("service has started") { service.started? }
```

* Providing alternate ```until``` methods:

```ruby
   Wait.until!("an exception does not occur") { foo.re_try! }
   Wait.until_true!("true is returned") { foo.truthy? }
   Wait.until_false!("false is returned") { foo.falsey? }
```

* Optionally allowing a timeout per ```until``` method call:

```ruby
   Wait.until!("an exception does not occur", timeout_in_seconds: 10) { foo.re_try! }
```

* Optionally performing diagnostics when a timeout occurs:

```ruby
   Wait.until!("resource contains something", on_failure: logger.log(resource.contents)) { resource.contains?("foo") }
```

Status
------

[![Build Status](https://travis-ci.org/MYOB-Technology/wait_until.png)](https://travis-ci.org/MYOB-Technology/wait_until)
[![Gem Version](https://badge.fury.io/rb/wait_until.png)](http://badge.fury.io/rb/wait_until)
[![Dependency Status](https://gemnasium.com/MYOB-Technology/wait_until.png)](https://gemnasium.com/MYOB-Technology/wait_until)

Usage
-----

* ```gem install wait_until```

```ruby
    require 'wait_until'

    ::Wait.default_timeout_in_seconds = 5
```

Requirements
------------

* Ruby 1.9.3, 2.0 or 2.1
