** 0.3.0 **

Breaking:
* ::Wait methods support optional failure_message and description.  failure_message takes precedence when a time-out occurs.

** 0.2.0 **

New:
* ::Wait methods support on_failure option that provides an ability to diagnose failures

Misc:
* Refactored to waiting for an _Operation_ to complete
