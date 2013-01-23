library hashroute;
import 'dart:html';
import 'match.dart';

abstract class HashRouterHandler {
	void handle(String path, Map<String,String> values);
}

class PatternHandlerPair {
	String pattern_;
	HashRouterHandler handler_;

	PatternHandlerPair(this.pattern_, this.handler_);

	String get pattern => pattern_;
	HashRouterHandler get handler => handler_;
}

class _HashRouterFuncHandler extends HashRouterHandler {
	Function f_;
	_HashRouterFuncHandler(this.f_);

	void handle(String path, Map<String,String> values) {
		f_(path, values);
	}
}

class HashRouter {

	var routes;

	HashRouter() {
		routes = [];
		window.on.hashChange.add( (e) {
			_handleNewRoute();
		});
	}

	void _handleNewRoute() {
		Map<String,String> values;
		HashRouterHandler handler;
		String path = window.location.hash;

		for (var r in routes) {
			values = new Map<String,String>();

			Matcher m = new Matcher(r.pattern, path);

			if (m.matches()) {
				r.handler.handle(path.substring(1, path.length), m.values);
				return;
			}
		}
	}

	void addHandler(String pattern, HashRouterHandler handler) {
		routes.add(new PatternHandlerPair('#${pattern}', handler));
	}

	void addHandlerFunc(String pattern, Function handleFunc) {
		addHandler(pattern, new _HashRouterFuncHandler(handleFunc));
	}

	void goTo(String route) {
		window.location.hash = route;
	}

	void run() {
		if (window.location != "") {
			String saved_hash = window.location.hash;
			window.location.hash = "";
			this.goTo(saved_hash);
		}
	}
}

