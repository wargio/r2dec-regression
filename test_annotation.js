const fs = require('fs');
function _p(x, d) {
	x = (['object', 'undefined'].indexOf(typeof(x)) >= 0 && !x) ? "" : x.toString();
	return x + " ".repeat(d - x.length);
}

function _j(x) {

}

if (process.argv[2]) {
	const rawdata = fs.readFileSync(process.argv[2]);
	try {
		const data = JSON.parse(rawdata);
		const code = data.code;
		const anno = data.annotations;
		anno.forEach((x) => {
			if (x.type == "offset") {
				console.log(_p(x.start, 4), _p(x.end, 4), _p(x.end - x.start, 4), _p(x.type, 20), _p("", 20), JSON.stringify(code.substring(x.start, x.end)));
			} else if (x.name) {
				console.log(_p(x.start, 4), _p(x.end, 4), _p(x.end - x.start, 4), _p(x.type, 20), _p("", 20), JSON.stringify(x.name), JSON.stringify(code.substring(x.start, x.end)));
			} else {
				console.log(_p(x.start, 4), _p(x.end, 4), _p(x.end - x.start, 4), _p(x.type, 20), _p(x.syntax_highlight, 20), JSON.stringify(code.substring(x.start, x.end)));
			}
		});
	} catch(e) {
		console.log(rawdata.toString());
	}
} else {
	console.log(process.argv[0], "<file.json>");
}