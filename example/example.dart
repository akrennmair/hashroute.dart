import 'dart:html';
import 'package:hashroute/hashroute.dart' as hr;

void main() {
	hr.HashRouter router = new hr.HashRouter();
	router.addHandlerFunc("/foo", (p, v) => write('called /foo'));
	router.addHandlerFunc('/bar/:id', (p, v) => write('called bar (id = ${v["id"]})'));
	router.addHandlerFunc('/baz=:id/:foo', (p, v) => write('called baz = ${v["id"]} foo = ${v["foo"]} complete path: ${p}'));
	router.addHandlerFunc('/', (p, v) => write('catch-all handler: ${p}'));

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
void write(String message) {
  document.query('#text').innerHTML = "${message}";
}
