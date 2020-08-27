var fs = require('fs');
var pyinterp = require('./_tmpdir/pyinterp_node.js');

function print_stdout(msg, rte) {
  console.log(msg);
};

var args = process.argv.slice(2);

fs.readFile(args[0], 'utf8', function(err, data) {
  if (err) throw err;
  return pyinterp.interp_source(data, {trace: false});
});
