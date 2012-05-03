#library('hashroute');
#import('dart:html');

interface HashRouterHandler {
	void handle(String path, Map<String,String> values);
}

class PatternHandlerPair {
	String pattern_;
	HashRouterHandler handler_;

	PatternHandlerPair(this.pattern_, this.handler_);

	String get pattern() => pattern_;
	HashRouterHandler get handler() => handler_;
}

class _HashRouterFuncHandler implements HashRouterHandler {
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
			//print("route = ${r.pattern} path = ${path}");
			int i = 0;
			int j = 0;
			while (i < path.length) {
				if (j >= r.pattern.length) {
					if (r.pattern[r.pattern.length-1] == '/') {
						handler = r.handler;
					}
					break;
				} else if (r.pattern[j] == ':') {
					String name = _find(r.pattern, '/', j+1);
					String value  = _find(path, '/', i);
					//print("name = ${name} value = ${value}");
					values[name] = value;
					j += name.length + 1;
					i += value.length;
				} else if (r.pattern[j] == path[i]) {
					i++;
					j++;
				} else {
					break;
				}
			}

			//print("j = ${j} pattern length = ${r.pattern.length}");
			if (j == r.pattern.length) {
				handler = r.handler;
			}

			if (handler != null) {
				handler.handle(path.substring(1, path.length), values);
				return;
			}
		}
	}

	String _find(String s, String c, int i) {
		int j = i;
		while (j < s.length && s[j] != c) {
			j++;
		}
		return s.substring(i, j);
	}

	void addHandler(String pattern, HashRouterHandler handler) {
		routes.add(new PatternHandlerPair('#' + pattern, handler));
	}

	void addHandlerFunc(String pattern, Function handleFunc) {
		addHandler(pattern, new _HashRouterFuncHandler(handleFunc));
	}

	void goTo(String route) {
		window.location.hash = route;
	}

	void run() {
		if (window.location.hash != "") {
			this.goTo(window.location.hash);
		}
	}
}

