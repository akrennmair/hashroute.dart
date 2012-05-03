DART_SRC=example.dart
JS_SRC=$(DART_SRC).js

all: $(JS_SRC)

$(JS_SRC): $(DART_SRC) hashroute.dart
	$$DART_SDK/bin/frogc --enable-type-checks $< || ( $(RM) $@ && exit 1 )
	yui-compressor --line-break 120 -o $@ $@ || true

clean:
	$(RM) $(JS_SRC)

