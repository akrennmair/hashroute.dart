import 'package:unittest/unittest.dart';
import 'package:hashroute/match.dart' as hr;

void main() {
	hr.Matcher m;

	test("pattern / matches /", () {
		m = new hr.Matcher("/", "/");
		expect(m.matches(), equals(true));
	});
	test("pattern / matches /foo", () {
		m = new hr.Matcher("/", "/foo");
		expect(m.matches(), equals(true));
	});

	test("pattern /:id matches /23", () {
		m = new hr.Matcher("/:id", "/23");
		expect(m.matches(), equals(true));
		expect(m.values["id"], equals("23"));
	});

	test("pattern /:id doesn't match /", () {
		m = new hr.Matcher("/:id", "/");
		expect(m.matches(), equals(false));
	});

	test("pattern /:id doesn't match /42/foo", () {
		m = new hr.Matcher("/:id", "/42/foo");
		expect(m.matches(), equals(false));
	});

	test("pattern /:id/ matches /23/", () {
		m = new hr.Matcher("/:id/", "/23/");
		expect(m.matches(), equals(true));
		expect(m.values["id"], equals("23"));
	});

	test("pattern /:id/ matches /9001/quux matches 9001 and ignores quux", () {
		m = new hr.Matcher("/:id/", "/9001/quux");
		expect(m.matches(), equals(true));
		expect(m.values["id"], equals("9001"));
	});

	test("pattern /:foo/v:bar/:baz matches /23/v42/100", () {
		m = new hr.Matcher("/:foo/v:bar/:baz", "/23/v42/100");
		expect(m.matches(), equals(true));
		expect(m.values["foo"], equals("23"));
		expect(m.values["bar"], equals("42"));
		expect(m.values["baz"], equals("100"));
	});

}
