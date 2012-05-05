# README for hashroute.dart

hashroute.dart is a simple location hash router for Dart. Using it is simple:
you create a new HashRouter object, and with the `addHandler()` resp.
`addHandlerFunc()` methods, you can add handlers for routes. Routes are
specified in a Sinatra-like style.

With the `goTo()` method, you can set the location hash, which will then trigger
the corresponding handler (if any of your routes matches).

And with the `run()` method, you can call the location hash that is currently
set. You will need this if you want to create single-page apps with 
copy-paste-able URLs where the location hash references data or a specific 
action that shall be executed.

Currently, the best documentation is the example and hashroute.dart itself.
The code is simple, so it should be reasonably easy to understand.

## License

See the file LICENSE for details.

## Author

Andreas Krennmair <ak@synflood.at>
