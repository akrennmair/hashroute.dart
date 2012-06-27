#import('dart:html');
#import('hashroute.dart');

void main() {
	HashRouter router = new HashRouter();
	router.addHandlerFunc("/foo", (p, v) => print('called /foo'));
	router.addHandlerFunc('/bar/:id', (p, v) => print('called bar (id = ${v["id"]})'));
	router.addHandlerFunc('/baz=:id/:foo', (p, v) => print('called baz = ${v["id"]} foo = ${v["foo"]} complete path: ${p}'));
	router.addHandlerFunc('/', (p, v) => print('catch-all handler: ${p}'));

	document.query('#btn1').on.click.add( (event) {
		event.preventDefault();
		router.goTo("/foo");
	});
	document.query('#btn2').on.click.add( (event) {
		event.preventDefault();
		router.goTo("/bar/23");
	});
	document.query('#btn3').on.click.add( (event) {
		event.preventDefault();
		router.goTo('/baz=42/9001/foo');
	});

	router.run();
}
