## ChocolateShell

### Motivation

The chocolate shell is a place where error handling and logging take place away from business logic, or the happy path.  Using this library will allow:

- Clean separation of logging, error handling and the happy path (the chocolate shell and the creamy center)
- Fail fast for immutable handling of state during error
- Strict post-conditions for composability and control in the face of failure
- Scoping of logging and error handling by use case

### TODO

- custom communicative error callstack
- add precondition check
- pass in error strategy on init (value, {opts}); #subscribe
- consider adding retry mechanism to error handler
- add a failure if the value is nil going into another method -- broken windows theory
- semaphores and circuit breaker, for less coupled components
- custom rubocops to enforce some of these things, like coupling of components and good error handling capabilities/strategies (eg: Cop/FailFast: ensures no begins/trys are in the methods)
