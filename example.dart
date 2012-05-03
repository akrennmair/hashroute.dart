#import('dart:html');
#import('hashroute.dart');

void main() {
	window.on.contentLoaded.add( (e) {
		HashRouter router = new HashRouter();
		router.addHandlerFunc("/foo", (p, v) => window.alert('called /foo'));
		router.addHandlerFunc('/bar/:id', (p, v) => window.alert('called bar (id = ${v["id"]})'));
		router.addHandlerFunc('/baz=:id/:foo', (p, v) => window.alert('called baz = ${v["id"]} foo = ${v["foo"]} complete path: ${p}'));
		router.addHandlerFunc('/', (p, v) => window.alert('catch-all handler: ${p}'));

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
	});

}
