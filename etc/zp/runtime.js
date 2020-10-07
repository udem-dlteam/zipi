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

function dict_pop(d, key, default_){
    if (Object.prototype.hasOwnProperty.call(d, key)) {
        var val = d[key];
        delete d[key];
        return val;
    } else {
        return default_;
    }
};

function dict_keys(d){
    return Object.keys(d);
}

function dict_copy(d){
    return Object.assign(make_dict(), d);
}

function dict_items(d){
    return Object.entries(d);
}

function gui_wait_for_click(ast, msg, continue_execution) {
    console.log('at ' + ast.lineno + '.' + (ast.col_offset + 1) + '-' + ast.end_lineno + '.' + (ast.end_col_offset + 1) + msg);
    return continue_execution;
};

function py_tokenset() {
    return Array.prototype.slice.call(arguments, py_tokenset.length);
};

function dict_has(d, a) {
    if (d === undefined) {
        return false;
    } else return Object.prototype.hasOwnProperty.call(d, a);
}

function dict_len(obj){
    return Object.keys(obj).length
}

function chr(code) {
    return String.fromCodePoint.apply(null, [code]);
}

function ord(char){
    return char.charCodeAt(0);
}

function hasattr(obj, attr){
    return obj !== undefined && obj[attr] !== undefined;
}

function getattr(obj, attr, default_){
    let val = obj[attr];
    if (val === undefined){
        return default_;
    } else {
        return val;
    }
}

function tuple_to_list(tup) {tup.slice();};

function list_to_tuple(lst) {lst.slice();};

function runtime_random() {
  return Math.random();
}

function list_new(size, default_){
    return Array.from({length: size}, function() {return default_;});
}

function list_concat(lst1, lst2){
    return lst1.concat(lst2);
}

function list_repeat(lst, n){
    return Array(n).fill(lst).flat();
}

function list_reversed(lst){
    return lst.slice().reverse();
}

function list_pop(lst){
    lst.pop()
}

function string_mul(s, times){
    if (times <= 0) {
        return "";
    } else{
        return s.repeat(times);
    }
}

function string_eq(s1, s2) {
    return s1 === s2;
}

function string_ne(s1, s2) {
    return s1 !== s2;
}

function string_lt(s1, s2) {
    return s1 < s2;
}

function string_le(s1, s2) {
    return s1 <= s2;
}

function string_gt(s1, s2) {
    return s1 > s2;
}

function string_ge(s1, s2) {
    return s1 >= s2;
}