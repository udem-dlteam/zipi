var fs = require('fs');
var args = process.argv.slice(2);

if (args.length > 1) {
  if (args[0] === '-nb') {
    var pyinterp = require('./_tmpdir/pyinterp_node_no_bigint.js');
    var file = args[1];
  } else {
    throw "unrecognized option " + args[0];
  }
} else {
  pyinterp = require('./_tmpdir/pyinterp_node.js');
  file = args[0];
}

var data = fs.readFileSync(file, 'utf8');
pyinterp.interp_source(data, {trace: true});
