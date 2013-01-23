library hashroute;

class Matcher {
	String pattern;
	String path;
	Map<String,String> v;

	Matcher(this.pattern, this.path);

	Map<String,String> get values => v;

	bool matches() {
		v = new Map<String,String>();

		int i = 0;
		int j = 0;
		while (i < path.length) {
			if (j >= pattern.length) {
				if (pattern[pattern.length-1] == '/') {
					return true;
				}
				return false;
			} else if (pattern[j] == ':') {
				String name = _find(pattern, '/', j+1);
				String value  = _find(path, '/', i);
				v[name] = value;
				j += name.length + 1;
				i += value.length;
			} else if (pattern[j] == path[i]) {
				i++;
				j++;
			} else {
				break;
			}
		}

		if (j == pattern.length) {
			return true;
		}
		return false;
	}

	String _find(String s, String c, int i) {
		int j = i;
		while (j < s.length && s[j] != c) {
			j++;
		}
		return s.substring(i, j);
	}

}
