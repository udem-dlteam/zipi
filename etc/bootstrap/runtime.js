String.prototype.lstrip = function() {
    return this.replace(/^\s+/g, '');
};

Array.prototype.extend = function(arr) {
  arr.forEach(function(v) {
    this.push(v);
  }, this);
};

function isEmpty(obj) {
    if (obj === absent) {
        return true;
    } else {
        return false;
    }
};

function make_dict() {
    return {};
};

function dict_get(d, key, _default) {
    if (Object.prototype.hasOwnProperty.call(d, key)) {
        return d[key];
    } else {
        return _default;
    }
};

function dict_set(d, key, value) {
    d[key] = value;
};

function gui_wait_for_click(ast, msg, continue_execution) {
    console.log('at ' + ast.lineno + '.' + (ast.col_offset + 1) + '-' + ast.end_lineno + '.' + (ast.end_col_offset + 1) + msg);
    return continue_execution;
};

function py_tokenset() {
    return Array.prototype.slice.call(arguments, py_tokenset.length);
};

function dict_has(d, a) {
    if (Object.prototype.hasOwnProperty.call(d, a)) {
        return true;
    } else {
        return false;
    }
};

function chr(code) {
    return String.fromCharCode.apply(null, [code]);
}
