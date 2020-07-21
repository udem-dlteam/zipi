# zp

## Instructions

```
usage: zp.py [-h] [-f FILE] [-d]

CLI to zp bootstrap compiler.

optional arguments:
  -h, --help            show this help message and exit
  -f FILE, --file FILE  file to compile
  -d, --debug           add debug information (default False)
```

### Example

Compile with:

```python
➜  bootstrap git:(zp-dev) ✗ python3 zp.py -f ../../parser/zast.py
../../parser/zast.py compiled successfully to ../../parser/zast.js.
```

Pretty-printed output:

```javascript
"use strict";
String.prototype.lstrip = function() {
    return this.replace(/^\s+/g, '');
};
"\n    zast\n    ~~~~\n\n    Zipi's abstract syntax tree module.\n";
var ENDMARKER = 0;
var NAME = 1;
var NUMBER = 2;
var STRING = 3;
var NEWLINE = 4;
var INDENT = 5;
var DEDENT = 6;
var LPAR = 7;
var RPAR = 8;
var LSQB = 9;
var RSQB = 10;
var COLON = 11;
var COMMA = 12;
var SEMI = 13;
var PLUS = 14;
var MINUS = 15;
var STAR = 16;
var SLASH = 17;
var VBAR = 18;
var AMPER = 19;
var LESS = 20;
var GREATER = 21;
var EQUAL = 22;
var DOT = 23;
var PERCENT = 24;
var BACKQUOTE = 25;
var LBRACE = 26;
var RBRACE = 27;
var EQEQUAL = 28;
var NOTEQUAL = 29;
var LESSEQUAL = 30;
var GREATEREQUAL = 31;
var TILDE = 32;
var CIRCUMFLEX = 33;
var LEFTSHIFT = 34;
var RIGHTSHIFT = 35;
var DOUBLESTAR = 36;
var PLUSEQUAL = 37;
var MINEQUAL = 38;
var STAREQUAL = 39;
var SLASHEQUAL = 40;
var PERCENTEQUAL = 41;
var AMPEREQUAL = 42;
var VBAREQUAL = 43;
var CIRCUMFLEXEQUAL = 44;
var LEFTSHIFTEQUAL = 45;
var RIGHTSHIFTEQUAL = 46;
var DOUBLESTAREQUAL = 47;
var DOUBLESLASH = 48;
var DOUBLESLASHEQUAL = 49;
var AT = 50;
var OP = 51;
var ERRORTOKEN = 52;
var N_TOKENS = 53;
var NT_OFFSET = 256;
var ELLIPSIS = 54;
var TYPE_COMMENT = 55;
var FALSE = 56;
var NONE = 57;
var TRUE = 58;
var AND = 59;
var AS = 60;
var ASSERT = 61;
var BREAK = 62;
var CLASS = 63;
var CONTINUE = 64;
var DEF = 65;
var DEL = 66;
var ELIF = 67;
var ELSE = 68;
var EXCEPT = 69;
var FINALLY = 70;
var FOR = 71;
var FROM = 72;
var GLOBAL = 73;
var IF = 74;
var IMPORT = 75;
var IN = 76;
var IS = 77;
var LAMBDA = 78;
var NONLOCAL = 79;
var NOT = 80;
var OR = 81;
var PASS = 82;
var RAISE = 83;
var RETURN = 84;
var TRY = 85;
var WHILE = 86;
var WITH = 87;
var YIELD = 88;
var ASYNC = 89;
var AWAIT = 90;
var tok_name = {};
tok_name[ENDMARKER] = "ENDMARKER";
tok_name[NAME] = "NAME";
tok_name[NUMBER] = "NUMBER";
tok_name[STRING] = "STRING";
tok_name[NEWLINE] = "NEWLINE";
tok_name[INDENT] = "INDENT";
tok_name[DEDENT] = "DEDENT";
tok_name[LPAR] = "LPAR";
tok_name[RPAR] = "RPAR";
tok_name[LSQB] = "LSQB";
tok_name[RSQB] = "RSQB";
tok_name[COLON] = "COLON";
tok_name[COMMA] = "COMMA";
tok_name[SEMI] = "SEMI";
tok_name[PLUS] = "PLUS";
tok_name[MINUS] = "MINUS";
tok_name[STAR] = "STAR";
tok_name[SLASH] = "SLASH";
tok_name[VBAR] = "VBAR";
tok_name[AMPER] = "AMPER";
tok_name[LESS] = "LESS";
tok_name[GREATER] = "GREATER";
tok_name[EQUAL] = "EQUAL";
tok_name[DOT] = "DOT";
tok_name[PERCENT] = "PERCENT";
tok_name[BACKQUOTE] = "BACKQUOTE";
tok_name[LBRACE] = "LBRACE";
tok_name[RBRACE] = "RBRACE";
tok_name[EQEQUAL] = "EQEQUAL";
tok_name[NOTEQUAL] = "NOTEQUAL";
tok_name[LESSEQUAL] = "LESSEQUAL";
tok_name[GREATEREQUAL] = "GREATEREQUAL";
tok_name[TILDE] = "TILDE";
tok_name[CIRCUMFLEX] = "CIRCUMFLEX";
tok_name[LEFTSHIFT] = "LEFTSHIFT";
tok_name[RIGHTSHIFT] = "RIGHTSHIFT";
tok_name[DOUBLESTAR] = "DOUBLESTAR";
tok_name[PLUSEQUAL] = "PLUSEQUAL";
tok_name[MINEQUAL] = "MINEQUAL";
tok_name[STAREQUAL] = "STAREQUAL";
tok_name[SLASHEQUAL] = "SLASHEQUAL";
tok_name[PERCENTEQUAL] = "PERCENTEQUAL";
tok_name[AMPEREQUAL] = "AMPEREQUAL";
tok_name[VBAREQUAL] = "VBAREQUAL";
tok_name[CIRCUMFLEXEQUAL] = "CIRCUMFLEXEQUAL";
tok_name[LEFTSHIFTEQUAL] = "LEFTSHIFTEQUAL";
tok_name[RIGHTSHIFTEQUAL] = "RIGHTSHIFTEQUAL";
tok_name[DOUBLESTAREQUAL] = "DOUBLESTAREQUAL";
tok_name[DOUBLESLASH] = "DOUBLESLASH";
tok_name[DOUBLESLASHEQUAL] = "DOUBLESLASHEQUAL";
tok_name[AT] = "AT";
tok_name[OP] = "OP";
tok_name[N_TOKENS] = "???";
tok_name[ERRORTOKEN] = "ERRORTOKEN";
tok_name[ELLIPSIS] = "ELLIPSIS";
tok_name[TYPE_COMMENT] = "TYPE_COMMENT";
tok_name[FALSE] = "FALSE";
tok_name[NONE] = "NONE";
tok_name[TRUE] = "TRUE";
tok_name[AND] = "AND";
tok_name[AS] = "AS";
tok_name[ASSERT] = "ASSERT";
tok_name[BREAK] = "BREAK";
tok_name[CLASS] = "CLASS";
tok_name[CONTINUE] = "CONTINUE";
tok_name[DEF] = "DEF";
tok_name[DEL] = "DEL";
tok_name[ELIF] = "ELIF";
tok_name[ELSE] = "ELSE";
tok_name[EXCEPT] = "EXCEPT";
tok_name[FINALLY] = "FINALLY";
tok_name[FOR] = "FOR";
tok_name[FROM] = "FROM";
tok_name[GLOBAL] = "GLOBAL";
tok_name[IF] = "IF";
tok_name[IMPORT] = "IMPORT";
tok_name[IN] = "IN";
tok_name[IS] = "IS";
tok_name[LAMBDA] = "LAMBDA";
tok_name[NONLOCAL] = "NONLOCAL";
tok_name[NOT] = "NOT";
tok_name[OR] = "OR";
tok_name[PASS] = "PASS";
tok_name[RAISE] = "RAISE";
tok_name[RETURN] = "RETURN";
tok_name[TRY] = "TRY";
tok_name[WHILE] = "WHILE";
tok_name[WITH] = "WITH";
tok_name[YIELD] = "YIELD";
tok_name[ASYNC] = "ASYNC";
tok_name[AWAIT] = "AWAIT";
var kw = {};
kw["False"] = FALSE;
kw["None"] = NONE;
kw["True"] = TRUE;
kw["and"] = AND;
kw["as"] = AS;
kw["assert"] = ASSERT;
kw["break"] = BREAK;
kw["class"] = CLASS;
kw["continue"] = CONTINUE;
kw["def"] = DEF;
kw["del"] = DEL;
kw["elif"] = ELIF;
kw["else"] = ELSE;
kw["except"] = EXCEPT;
kw["finally"] = FINALLY;
kw["for"] = FOR;
kw["from"] = FROM;
kw["global"] = GLOBAL;
kw["if"] = IF;
kw["import"] = IMPORT;
kw["in"] = IN;
kw["is"] = IS;
kw["lambda"] = LAMBDA;
kw["nonlocal"] = NONLOCAL;
kw["not"] = NOT;
kw["or"] = OR;
kw["pass"] = PASS;
kw["raise"] = RAISE;
kw["return"] = RETURN;
kw["try"] = TRY;
kw["while"] = WHILE;
kw["with"] = WITH;
kw["yield"] = YIELD;
kw["async"] = ASYNC;
kw["await"] = AWAIT;

function byte_at(x, i) {
    if (((typeof x) === "string")) {
        return x[i].charCodeAt(0);
    } else {
        return x[i];
    };
};

function append_eol(buf) {
    return (buf + (((typeof buf) === "string") ? "\n" : "\n"));
};
var stats = {};
var found = new Array(68).fill(0);

function init_stats() {
    stats["bol"] = 0;
    stats["not_bol"] = 0;
    stats["k == KIND_NAME"] = 0;
    stats["k >= KIND_TILDE"] = 0;
    stats["k >= KIND_LPAR"] = 0;
    stats["k <= KIND_LEFTSHIFTEQUAL"] = 0;
    stats["k <= KIND_STRING"] = 0;
    stats["k == KIND_STRING"] = 0;
    stats["k == KIND_DOT"] = 0;
    stats["k == KIND_COMMENT"] = 0;
    stats["k == KIND_NEWLINE"] = 0;
    stats["k == KIND_CONTINUATION"] = 0;
    stats["OTHER"] = 0;
    stats["SPECIAL"] = 0;
};

function inc_found(index) {
    found[index] += 1;
};

function inc_stats(name) {
    stats[name] += 1;
};

function show_stats() {
    console.log("\n***** STATISTICS *****");
    console.log("\n----- CHARACTER KINDS ENCOUNTERED:");
    for (const g0 in [...Array(found.length).keys()]) {
        console.log(String(found[g0]), "=", kind_names[g0]);
    };
    console.log("\n----- DISTRIBUTION OF CHARACTER KINDS TESTED:");
    for (const g1 in stats) {
        console.log(JSON.stringify(stats[g1]), "=", g1);
    };
};
var KIND_NUMBER = 0;
var KIND_NAME = 10;
var KIND_STRING = 11;
var KIND_DOT = 12;
var KIND_COMMENT = 13;
var KIND_CONTINUATION = 14;
var KIND_WHITESPACE = 15;
var KIND_NEWLINE = 16;
var KIND_ERROR = 17;
var KIND_STAR = 18;
var KIND_STAREQUAL = 19;
var KIND_DOUBLESTAR = 20;
var KIND_DOUBLESTAREQUAL = 21;
var KIND_SLASH = 22;
var KIND_SLASHEQUAL = 23;
var KIND_DOUBLESLASH = 24;
var KIND_DOUBLESLASHEQUAL = 25;
var KIND_GREATER = 26;
var KIND_GREATEREQUAL = 27;
var KIND_RIGHTSHIFT = 28;
var KIND_RIGHTSHIFTEQUAL = 29;
var KIND_LESS = 30;
var KIND_LESSEQUAL = 31;
var KIND_LEFTSHIFT = 32;
var KIND_LEFTSHIFTEQUAL = 33;
var KIND_PERCENT = 34;
var KIND_PERCENTEQUAL = 35;
var KIND_AMPER = 36;
var KIND_AMPEREQUAL = 37;
var KIND_VBAR = 38;
var KIND_VBAREQUAL = 39;
var KIND_CIRCUMFLEX = 40;
var KIND_CIRCUMFLEXEQUAL = 41;
var KIND_EQUAL = 42;
var KIND_EQEQUAL = 43;
var KIND_PLUS = 44;
var KIND_PLUSEQUAL = 45;
var KIND_MINUS = 46;
var KIND_MINEQUAL = 47;
var KIND_NOT = 48;
var KIND_NOTEQUAL = 49;
var KIND_AT = 50;
var KIND_ATEQUAL = 51;
var KIND_COLON = 52;
var KIND_COLONEQUAL = 53;
var KIND_TILDE = 54;
var KIND_COMMA = 55;
var KIND_BACKQUOTE = 56;
var KIND_SEMI = 57;
var KIND_LPAR = 58;
var KIND_LSQB = 59;
var KIND_LBRACE = 60;
var KIND_RPAR = 61;
var KIND_RSQB = 62;
var KIND_RBRACE = 63;
var KIND_ELLIPSIS = 64;
var KIND_INDENT = 65;
var KIND_DEDENT = 66;
var KIND_EOF = 67;
var BYTE_STRING = 0;
var PLAIN_STRING = 1;
var UNICODE_STRING = 2;
var kind_to_token = [NUMBER, NUMBER, NUMBER, NUMBER, NUMBER, NUMBER, NUMBER, NUMBER, NUMBER, NUMBER, NAME, STRING, DOT, 999, 999, 999, NEWLINE, ERRORTOKEN, STAR, STAREQUAL, DOUBLESTAR, DOUBLESTAREQUAL, SLASH, SLASHEQUAL, DOUBLESLASH, DOUBLESLASHEQUAL, GREATER, GREATEREQUAL, RIGHTSHIFT, RIGHTSHIFTEQUAL, LESS, LESSEQUAL, LEFTSHIFT, LEFTSHIFTEQUAL, PERCENT, PERCENTEQUAL, AMPER, AMPEREQUAL, VBAR, VBAREQUAL, CIRCUMFLEX, CIRCUMFLEXEQUAL, EQUAL, EQEQUAL, PLUS, PLUSEQUAL, MINUS, MINEQUAL, 999, NOTEQUAL, AT, 999, COLON, 999, TILDE, COMMA, BACKQUOTE, SEMI, LPAR, LSQB, LBRACE, RPAR, RSQB, RBRACE, ELLIPSIS, INDENT, DEDENT, ENDMARKER];
var kind_names = ["KIND_NUMBER", "KIND_1", "KIND_2", "KIND_3", "KIND_4", "KIND_5", "KIND_6", "KIND_7", "KIND_8", "KIND_9", "KIND_NAME", "KIND_STRING", "KIND_DOT", "KIND_COMMENT", "KIND_CONTINUATION", "KIND_WHITESPACE", "KIND_NEWLINE", "KIND_ERROR", "KIND_STAR", "KIND_STAREQUAL", "KIND_DOUBLESTAR", "KIND_DOUBLESTAREQUAL", "KIND_SLASH", "KIND_SLASHEQUAL", "KIND_DOUBLESLASH", "KIND_DOUBLESLASHEQUAL", "KIND_GREATER", "KIND_GREATEREQUAL", "KIND_RIGHTSHIFT", "KIND_RIGHTSHIFTEQUAL", "KIND_LESS", "KIND_LESSEQUAL", "KIND_LEFTSHIFT", "KIND_LEFTSHIFTEQUAL", "KIND_PERCENT", "KIND_PERCENTEQUAL", "KIND_AMPER", "KIND_AMPEREQUAL", "KIND_VBAR", "KIND_VBAREQUAL", "KIND_CIRCUMFLEX", "KIND_CIRCUMFLEXEQUAL", "KIND_EQUAL", "KIND_EQEQUAL", "KIND_PLUS", "KIND_PLUSEQUAL", "KIND_MINUS", "KIND_MINEQUAL", "KIND_NOT", "KIND_NOTEQUAL", "KIND_AT", "KIND_ATEQUAL", "KIND_COLON", "KIND_COLONEQUAL", "KIND_TILDE", "KIND_COMMA", "KIND_BACKQUOTE", "KIND_SEMI", "KIND_LPAR", "KIND_LSQB", "KIND_LBRACE", "KIND_RPAR", "KIND_RSQB", "KIND_RBRACE", "KIND_ELLIPSIS", "KIND_INDENT", "KIND_DEDENT", "KIND_EOF"];

function make_char_kind() {
    var char_kind = new Uint8Array(256);

    function set_char_kind(code, tok) {
        char_kind[code] = tok;
    };
    for (let g2 = 0; g2 < 256; g2++) {
        set_char_kind(g2, KIND_ERROR);
    };
    for (let g3 = 0; g3 < 10; g3++) {
        set_char_kind((48 + g3), g3);
    };
    for (let g4 = 0; g4 < 26; g4++) {
        set_char_kind((97 + g4), KIND_NAME);
        set_char_kind((65 + g4), KIND_NAME);
    };
    set_char_kind(95, KIND_NAME);
    set_char_kind(34, KIND_STRING);
    set_char_kind(39, KIND_STRING);
    set_char_kind(46, KIND_DOT);
    set_char_kind(35, KIND_COMMENT);
    set_char_kind(92, KIND_CONTINUATION);
    set_char_kind(32, KIND_WHITESPACE);
    set_char_kind(9, KIND_WHITESPACE);
    set_char_kind(12, KIND_WHITESPACE);
    set_char_kind(10, KIND_NEWLINE);
    set_char_kind(13, KIND_NEWLINE);
    set_char_kind(42, KIND_STAR);
    set_char_kind(47, KIND_SLASH);
    set_char_kind(62, KIND_GREATER);
    set_char_kind(60, KIND_LESS);
    set_char_kind(37, KIND_PERCENT);
    set_char_kind(38, KIND_AMPER);
    set_char_kind(124, KIND_VBAR);
    set_char_kind(94, KIND_CIRCUMFLEX);
    set_char_kind(61, KIND_EQUAL);
    set_char_kind(43, KIND_PLUS);
    set_char_kind(45, KIND_MINUS);
    set_char_kind(33, KIND_NOT);
    set_char_kind(64, KIND_AT);
    set_char_kind(58, KIND_COLON);
    set_char_kind(126, KIND_TILDE);
    set_char_kind(44, KIND_COMMA);
    set_char_kind(59, KIND_SEMI);
    set_char_kind(40, KIND_LPAR);
    set_char_kind(91, KIND_LSQB);
    set_char_kind(123, KIND_LBRACE);
    set_char_kind(41, KIND_RPAR);
    set_char_kind(93, KIND_RSQB);
    set_char_kind(125, KIND_RBRACE);
    return char_kind;
};
var char_kind = make_char_kind();
class TokenizerState {
    constructor(buf) {
        var self = this;
        self.buf = append_eol(buf);
        self.buf_len = buf.length;
        self.start = 0;
        self.end = 0;
        self.token = NEWLINE;
        self.line_start = 0;
        self.line_num = 1;
        self.paren_level = 0;
        self.indents = [0];
        self.dedents = 0;
        self.python = 2;
    };
};

function get_lineno(ts) {
    return ts.line_num;
};

function get_col_offset(ts) {
    return (ts.start - ts.line_start);
};

function get_end_lineno(ts) {
    return ts.line_num;
};

function get_end_col_offset(ts) {
    return (ts.end - ts.line_start);
};

function set_start(ast, lineno, col_offset) {
    ast.lineno = lineno;
    ast.col_offset = col_offset;
    return ast;
};

function set_end(ast, end_lineno, end_col_offset) {
    ast.end_lineno = end_lineno;
    ast.end_col_offset = end_col_offset;
    return ast;
};

function set_start_end(ts, lineno, col_offset, ast) {
    set_start(ast, lineno, col_offset);
    set_end(ast, ts.prev_end_lineno, ts.prev_end_col_offset);
    return ast;
};

function set_start_1token(ts, ast) {
    return set_start(ast, get_lineno(ts), get_col_offset(ts));
};

function set_end_1token(ts, ast) {
    return set_end(ast, get_end_lineno(ts), get_end_col_offset(ts));
};

function set_start_end_1token(ts, ast) {
    return set_end_1token(ts, set_start_1token(ts, ast));
};

function source(ts, start, end) {
    return ts.buf.slice(start, end);
};

function token(ts) {
    return source(ts, ts.start, ts.end);
};

function get_token(ts) {
    if ((ts.dedents > 0)) {
        ts.dedents -= 1;
        ts.token = DEDENT;
        return null;
    };
    var buf = ts.buf;
    var pos = ts.end;
    while (true) {
        if ((((pos === ts.line_start)) && ((ts.paren_level === 0)))) {
            inc_stats("bol");
            var col = 0;
            while (true) {
                var c = byte_at(buf, pos);
                pos += 1;
                if ((c === 32)) {
                    col += 1;
                } else {
                    if ((c === 9)) {
                        var col = ((((col / 8) >> 0) + 1) * 8);
                    } else {
                        if ((c === 12)) {
                            var col = 0;
                        } else {
                            break;
                        };
                    };
                };
            };
            if ((c === 35)) {
                while (true) {
                    var c = byte_at(buf, pos);
                    pos += 1;
                    if ((((c === 10)) || ((c === 13)))) {
                        break;
                    };
                };
            };
            if ((((c === 10)) || ((c === 13)))) {
                if ((((c === 13)) && ((byte_at(buf, pos) === 10)))) {
                    pos += 1;
                };
                ts.line_start = pos;
                ts.line_num += 1;
                if ((pos < ts.buf_len)) {
                    continue;
                };
                ts.start = ts.buf_len;
                ts.end = ts.buf_len;
                var n = (ts.indents.length - 1);
                if ((n > 0)) {
                    ts.indents = [0];
                    ts.dedents = (n - 1);
                    ts.token = DEDENT;
                    return null;
                };
                inc_found(KIND_EOF);
                ts.token = ENDMARKER;
                return null;
            };
            var n = ts.indents.length;
            var i = (n - 1);
            if ((ts.indents[i] < col)) {
                ts.indents.push(col);
                ts.start = (pos - 1);
                ts.end = (pos - 1);
                ts.token = INDENT;
                return null;
            };
            if ((col < ts.indents[i])) {
                while (true) {
                    if ((ts.indents[(i - 1)] <= col)) {
                        break;
                    };
                    i -= 1;
                };
                if ((ts.indents[(i - 1)] !== col)) {
                    console.log("inconsistent dedent");
                    ts.token = ERRORTOKEN;
                    return null;
                };
                ts.indents = ts.indents.slice("None", i);
                ts.dedents = ((n - i) - 1);
                ts.start = (pos - 1);
                ts.end = (pos - 1);
                ts.token = DEDENT;
                return null;
            };
            var k = char_kind[c];
        } else {
            inc_stats("not_bol");
            while (true) {
                var c = byte_at(buf, pos);
                var k = char_kind[c];
                pos += 1;
                if ((k !== KIND_WHITESPACE)) {
                    break;
                };
            };
            if ((k === KIND_NEWLINE)) {
                ts.start = (pos - 1);
                if ((((c === 13)) && ((byte_at(buf, pos) === 10)))) {
                    pos += 1;
                };
                ts.line_start = pos;
                ts.line_num += 1;
                if ((pos <= ts.buf_len)) {
                    if ((ts.paren_level === 0)) {
                        ts.end = pos;
                        ts.token = NEWLINE;
                        return null;
                    } else {
                        continue;
                    };
                };
                inc_found(KIND_EOF);
                ts.start = ts.buf_len;
                ts.end = ts.buf_len;
                ts.token = ENDMARKER;
                return null;
            };
        };
        ts.start = (pos - 1);
        if ((k === KIND_NAME)) {
            inc_stats("k == KIND_NAME");
            while (true) {
                var next = byte_at(buf, pos);
                var k = char_kind[next];
                if ((k > KIND_NAME)) {
                    break;
                };
                pos += 1;
            };
            if ((k === KIND_STRING)) {
                var c = (c & 223);
                if ((((c === 66)) || ((c === 85)))) {
                    var kind = ((c === 66) ? BYTE_STRING : UNICODE_STRING);
                    if ((ts.start === (pos - 1))) {
                        get_string(ts, (pos + 1), next, kind, false);
                        return null;
                    };
                    if ((ts.start === (pos - 2))) {
                        var c2 = (byte_at(buf, (ts.start + 1)) & 223);
                        if ((c2 === 82)) {
                            get_string(ts, (pos + 1), next, kind, true);
                            return null;
                        };
                    };
                } else {
                    if ((c === 82)) {
                        if ((ts.start === (pos - 1))) {
                            get_string(ts, (pos + 1), next, PLAIN_STRING, true);
                            return null;
                        };
                    };
                };
            };
            inc_found(KIND_NAME);
            ts.end = pos;
            ts.token = (kw[source(ts, ts.start, ts.end)] || NAME);
            return null;
        };
        if ((k >= KIND_TILDE)) {
            inc_stats("k >= KIND_TILDE");
            if ((k >= KIND_LPAR)) {
                inc_stats("k >= KIND_LPAR");
                if ((k >= KIND_RPAR)) {
                    ts.paren_level -= 1;
                } else {
                    ts.paren_level += 1;
                };
            };
            inc_found(1);
            ts.end = pos;
            ts.token = kind_to_token[k];
            return null;
        };
        inc_stats("OTHER");
        var next = byte_at(buf, pos);
        if ((k <= KIND_LEFTSHIFTEQUAL)) {
            inc_stats("k <= KIND_LEFTSHIFTEQUAL");
            if ((k < KIND_STAR)) {
                if ((k === KIND_NEWLINE)) {
                    inc_stats("k == KIND_NEWLINE");
                    if ((((c === 13)) && ((next === 10)))) {
                        pos += 1;
                    };
                    ts.line_start = pos;
                    if ((pos > ts.buf_len)) {
                        ts.start = ts.buf_len;
                        ts.end = ts.buf_len;
                        ts.token = ENDMARKER;
                        return null;
                    } else {
                        if ((((ts.paren_level > 0)) || ((ts.token === NEWLINE)))) {
                            continue;
                        } else {
                            ts.end = pos;
                            ts.token = NEWLINE;
                            return null;
                        };
                    };
                };
                if ((k === KIND_DOT)) {
                    inc_stats("k == KIND_DOT");
                    if ((char_kind[next] <= 9)) {
                        while (true) {
                            pos += 1;
                            var next = byte_at(buf, pos);
                            if ((char_kind[next] > 9)) {
                                break;
                            };
                        };
                        inc_found(KIND_NUMBER);
                        ts.end = pos;
                        ts.token = NUMBER;
                        return null;
                    } else {
                        if ((((next === 46)) && ((byte_at(buf, (pos + 1)) === 46)))) {
                            inc_found(KIND_ELLIPSIS);
                            ts.end = (pos + 2);
                            ts.token = ELLIPSIS;
                            return null;
                        };
                    };
                    inc_found(KIND_DOT);
                    ts.end = pos;
                    ts.token = DOT;
                    return null;
                };
                if ((k === KIND_STRING)) {
                    inc_stats("k == KIND_STRING");
                    inc_found(KIND_STRING);
                    get_string(ts, pos, c, PLAIN_STRING, false);
                    return null;
                };
                if ((k < KIND_STRING)) {
                    inc_stats("k <= KIND_STRING");
                    var base = 10;
                    if ((c === 48)) {
                        var next = (next & 223);
                        if ((next === 88)) {
                            var base = 16;
                            pos += 1;
                        } else {
                            if ((next === 79)) {
                                var base = 8;
                                pos += 1;
                            } else {
                                if ((next === 66)) {
                                    var base = 2;
                                    pos += 1;
                                } else {
                                    var base = 8;
                                };
                            };
                        };
                        var next = byte_at(buf, pos);
                    };
                    while (true) {
                        var k = char_kind[next];
                        if ((k <= 9)) {
                            {};
                        } else {
                            if ((k === KIND_NAME)) {
                                var k = ((next & 223) - 55);
                            } else {
                                k += 100;
                            };
                        };
                        if ((k > base)) {
                            break;
                        };
                        pos += 1;
                        var next = byte_at(buf, pos);
                    };
                    if ((((k === 21)) && ((ts.python === 2)))) {
                        pos += 1;
                    } else {
                        if ((k === (100 + KIND_DOT))) {
                            pos += 1;
                            while (true) {
                                var next = byte_at(buf, pos);
                                var k = char_kind[next];
                                if ((k > 9)) {
                                    break;
                                };
                                pos += 1;
                            };
                        };
                        var next = (next & 223);
                        if ((next === 69)) {
                            pos += 1;
                            var next = byte_at(buf, pos);
                            if ((((next === 43)) || ((next === 45)))) {
                                pos += 1;
                                var next = byte_at(buf, pos);
                            };
                            var k = char_kind[next];
                            if ((k <= 9)) {
                                while (true) {
                                    pos += 1;
                                    var next = byte_at(buf, pos);
                                    var k = char_kind[next];
                                    if ((k > 9)) {
                                        break;
                                    };
                                };
                            };
                        };
                    };
                    inc_found(KIND_NUMBER);
                    ts.end = pos;
                    ts.token = NUMBER;
                    return null;
                };
                if ((k === KIND_COMMENT)) {
                    inc_stats("k == KIND_COMMENT");
                    inc_found(KIND_COMMENT);
                    while ((byte_at(buf, pos) !== 10)) {
                        pos += 1;
                    };
                    continue;
                };
                inc_stats("k == KIND_CONTINUATION");
                inc_found(KIND_CONTINUATION);
                if ((next === 10)) {
                    pos += 1;
                    continue;
                };
                console.log("error bad continuation line");
                console.log(("c=" + JSON.stringify(c)));
                console.log(("next=" + JSON.stringify(next)));
                ts.token = 0;
                return null;
            };
            if ((next === c)) {
                inc_found(2);
                k += 2;
                pos += 1;
                var next = byte_at(buf, pos);
            };
        };
        inc_stats("SPECIAL");
        if ((next === 61)) {
            inc_found(3);
            k += 1;
            pos += 1;
        } else {
            if ((((k === KIND_LESS)) && ((next === 62)))) {
                inc_found(4);
                var k = KIND_NOTEQUAL;
                pos += 1;
            } else {
                if ((k === KIND_NOT)) {
                    inc_found(5);
                    var k = KIND_ERROR;
                } else {
                    inc_found(6);
                };
            };
        };
        ts.end = pos;
        ts.token = kind_to_token[k];
        return null;
    };
};

function get_string(ts, pos, c, kind, regexpr) {
    function _print(x) {
        {};
    };
    if (regexpr) {
        if ((kind === BYTE_STRING)) {
            _print("@@@@@@ string with BR prefix");
        } else {
            if ((kind === UNICODE_STRING)) {
                _print("@@@@@@ string with UR prefix");
            } else {
                _print("@@@@@@ string with R prefix");
            };
        };
    } else {
        if ((kind === BYTE_STRING)) {
            _print("@@@@@@ string with B prefix");
        } else {
            if ((kind === UNICODE_STRING)) {
                _print("@@@@@@ string with U prefix");
            } else {
                _print("@@@@@@ string with no prefix");
            };
        };
    };
    var buf = ts.buf;
    if ((((byte_at(buf, pos) === c)) && ((byte_at(buf, (pos + 1)) === c)))) {
        pos += 2;
        while (true) {
            var next = byte_at(buf, pos);
            if ((((next === c)) && ((byte_at(buf, (pos + 1)) === c)) && ((byte_at(buf, (pos + 2)) === c)))) {
                pos += 3;
                break;
            } else {
                if ((next === 92)) {
                    if ((byte_at(buf, (pos + 1)) === 10)) {
                        ts.line_num += 1;
                    };
                    pos += 2;
                } else {
                    if ((next === 10)) {
                        ts.line_num += 1;
                    };
                    pos += 1;
                };
            };
        };
    } else {
        while (true) {
            var next = byte_at(buf, pos);
            if ((next === c)) {
                pos += 1;
                break;
            } else {
                if ((next === 92)) {
                    if ((byte_at(buf, (pos + 1)) === 10)) {
                        ts.line_num += 1;
                    };
                    pos += 2;
                } else {
                    if ((next === 10)) {
                        var k = KIND_ERROR;
                        break;
                    } else {
                        pos += 1;
                    };
                };
            };
        };
    };
    ts.end = pos;
    ts.token = STRING;
};
class AST {
    _fields = [];
    _attributes = [];
};
class mod {
    _fields = [];
    _attributes = [];
};
class Module {
    _fields = ["body", "type_ignores"];
    _attributes = [];
    constructor(body, type_ignores) {
        var self = this;
        self.body = body;
        self.type_ignores = type_ignores;
    };
};
class type_ignore {
    _fields = [];
    _attributes = [];
};
class TypeIgnore {
    _fields = ["lineno", "tag"];
    _attributes = [];
    constructor(lineno, tag) {
        var self = this;
        self.lineno = lineno;
        self.tag = tag;
    };
};
class Interactive {
    _fields = ["body"];
    _attributes = [];
    constructor(body) {
        var self = this;
        self.body = body;
    };
};
class Expression {
    _fields = ["body"];
    _attributes = [];
    constructor(body) {
        var self = this;
        self.body = body;
    };
};
class FunctionType {
    _fields = ["argtypes", "returns"];
    _attributes = [];
    constructor(argtypes, returns) {
        var self = this;
        self.argtypes = argtypes;
        self.returns = returns;
    };
};
class Suite {
    _fields = ["body"];
    _attributes = [];
    constructor(body) {
        var self = this;
        self.body = body;
    };
};
class stmt {
    _fields = [];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
};
class FunctionDef {
    _fields = ["name", "args", "body", "decorator_list", "returns", "type_comment"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(name, args, body, decorator_list, returns, type_comment) {
        var self = this;
        self.name = name;
        self.args = args;
        self.body = body;
        self.decorator_list = decorator_list;
        self.returns = returns;
        self.type_comment = type_comment;
    };
};
class aarguments {
    _fields = ["posonlyargs", "args", "vararg", "kwonlyargs", "kw_defaults", "kwarg", "defaults"];
    _attributes = [];
    constructor(args, posonlyargs, vararg, kwonlyargs, kw_defaults, kwarg, defaults) {
        var self = this;
        self.args = args;
        self.posonlyargs = posonlyargs;
        self.vararg = vararg;
        self.kwonlyargs = kwonlyargs;
        self.kw_defaults = kw_defaults;
        self.kwarg = kwarg;
        self.defaults = defaults;
    };
};
class arg {
    _fields = ["arg", "annotation", "type_comment"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(arg, annotation, type_comment) {
        var self = this;
        self.arg = arg;
        self.annotation = annotation;
        self.type_comment = type_comment;
    };
};
class AsyncFunctionDef {
    _fields = ["name", "args", "body", "decorator_list", "returns", "type_comment"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(name, args, body, decorator_list, returns, type_comment) {
        var self = this;
        self.name = name;
        self.args = args;
        self.body = body;
        self.decorator_list = decorator_list;
        self.returns = returns;
        self.type_comment = type_comment;
    };
};
class ClassDef {
    _fields = ["name", "bases", "keywords", "body", "decorator_list"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(name, bases, keywords, body, decorator_list) {
        var self = this;
        self.name = name;
        self.bases = bases;
        self.keywords = keywords;
        self.body = body;
        self.decorator_list = decorator_list;
    };
};
class Return {
    _fields = ["value"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(value) {
        var self = this;
        self.value = value;
    };
};
class Delete {
    _fields = ["targets"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(targets) {
        var self = this;
        self.targets = targets;
    };
};
class Assign {
    _fields = ["targets", "value", "type_comment"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(targets, value, type_comment) {
        var self = this;
        self.targets = targets;
        self.value = value;
        self.type_comment = type_comment;
    };
};
class AugAssign {
    _fields = ["target", "op", "value"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(target, op, value) {
        var self = this;
        self.target = target;
        self.op = op;
        self.value = value;
    };
};
class AnnAssign {
    _fields = ["target", "annotation", "value", "simple"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(target, annotation, value, simple) {
        var self = this;
        self.target = target;
        self.annotation = annotation;
        self.value = value;
        self.simple = simple;
    };
};
class For {
    _fields = ["target", "iter", "body", "orelse", "type_comment"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(target, iter, body, orelse, type_comment) {
        var self = this;
        self.target = target;
        self.iter = iter;
        self.body = body;
        self.orelse = orelse;
        self.type_comment = type_comment;
    };
};
class AsyncFor {
    _fields = ["target", "iter", "body", "orelse", "type_comment"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(target, iter, body, orelse, type_comment) {
        var self = this;
        self.target = target;
        self.iter = iter;
        self.body = body;
        self.orelse = orelse;
        self.type_comment = type_comment;
    };
};
class While {
    _fields = ["test", "body", "orelse"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(test, body, orelse) {
        var self = this;
        self.test = test;
        self.body = body;
        self.orelse = orelse;
    };
};
class If {
    _fields = ["test", "body", "orelse"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(test, body, orelse) {
        var self = this;
        self.test = test;
        self.body = body;
        self.orelse = orelse;
    };
};
class With {
    _fields = ["items", "body", "type_comment"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(items, body, type_comment) {
        var self = this;
        self.items = items;
        self.body = body;
        self.type_comment = type_comment;
    };
};
class AsyncWith {
    _fields = ["items", "body", "type_comment"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(items, body, type_comment) {
        var self = this;
        self.items = items;
        self.body = body;
        self.type_comment = type_comment;
    };
};
class withitem {
    _fields = ["context_expr", "optional_vars"];
    _attributes = [];
    constructor(context_expr, optional_vars) {
        var self = this;
        self.context_expr = context_expr;
        self.optional_vars = optional_vars;
    };
};
class Raise {
    _fields = ["exc", "cause"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(exc, cause) {
        var self = this;
        self.exc = exc;
        self.cause = cause;
    };
};
class Try {
    _fields = ["body", "handlers", "orelse", "finalbody"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(body, handlers, orelse, finalbody) {
        var self = this;
        self.body = body;
        self.handlers = handlers;
        self.orelse = orelse;
        self.finalbody = finalbody;
    };
};
class excepthandler {
    _fields = [];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
};
class ExceptHandler {
    _fields = ["type", "name", "body"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(type, name, body) {
        var self = this;
        self.type = type;
        self.name = name;
        self.body = body;
    };
};
class Assert {
    _fields = ["test", "msg"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(test, msg) {
        var self = this;
        self.test = test;
        self.msg = msg;
    };
};
class Import {
    _fields = ["names"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(names) {
        var self = this;
        self.names = names;
    };
};
class ImportFrom {
    _fields = ["module", "names", "level"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(module, names, level) {
        var self = this;
        self.module = module;
        self.names = names;
        self.level = level;
    };
};
class alias {
    _fields = ["name", "asname"];
    _attributes = [];
    constructor(name, asname) {
        var self = this;
        self.name = name;
        self.asname = asname;
    };
};
class Global {
    _fields = ["names"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(names) {
        var self = this;
        self.names = names;
    };
};
class Nonlocal {
    _fields = ["names"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(names) {
        var self = this;
        self.names = names;
    };
};
class Expr {
    _fields = ["value"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(value) {
        var self = this;
        self.value = value;
    };
};
class Pass {
    _fields = [];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
};
class Break {
    _fields = [];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
};
class Continue {
    _fields = [];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
};
class expr {
    _fields = [];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
};
class expr_context {
    _fields = [];
    _attributes = [];
};
class Load {
    _fields = [];
    _attributes = [];
};
class Store {
    _fields = [];
    _attributes = [];
};
class Del {
    _fields = [];
    _attributes = [];
};
class AugLoad {
    _fields = [];
    _attributes = [];
};
class AugStore {
    _fields = [];
    _attributes = [];
};
class Param {
    _fields = [];
    _attributes = [];
};
class BoolOp {
    _fields = ["op", "values"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(op, values) {
        var self = this;
        self.op = op;
        self.values = values;
    };
};
class boolop {
    _fields = [];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
};
class And {
    _fields = [];
    _attributes = [];
};
class Or {
    _fields = [];
    _attributes = [];
};
class NamedExpr {
    _fields = ["target", "value"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(target, value) {
        var self = this;
        self.target = target;
        self.value = value;
    };
};
class BinOp {
    _fields = ["left", "op", "right"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(left, op, right) {
        var self = this;
        self.left = left;
        self.op = op;
        self.right = right;
    };
};
class operator {
    _fields = [];
    _attributes = [];
};
class Add {
    _fields = [];
    _attributes = [];
};
class Sub {
    _fields = [];
    _attributes = [];
};
class Mult {
    _fields = [];
    _attributes = [];
};
class Div {
    _fields = [];
    _attributes = [];
};
class FloorDiv {
    _fields = [];
    _attributes = [];
};
class Mod {
    _fields = [];
    _attributes = [];
};
class Pow {
    _fields = [];
    _attributes = [];
};
class LShift {
    _fields = [];
    _attributes = [];
};
class RShift {
    _fields = [];
    _attributes = [];
};
class BitOr {
    _fields = [];
    _attributes = [];
};
class BitXor {
    _fields = [];
    _attributes = [];
};
class BitAnd {
    _fields = [];
    _attributes = [];
};
class MatMult {
    _fields = [];
    _attributes = [];
};
class UnaryOp {
    _fields = ["op", "operand"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(op, operand) {
        var self = this;
        self.op = op;
        self.operand = operand;
    };
};
class unaryop {
    _fields = [];
    _attributes = [];
};
class UAdd {
    _fields = [];
    _attributes = [];
};
class USub {
    _fields = [];
    _attributes = [];
};
class Not {
    _fields = [];
    _attributes = [];
};
class Invert {
    _fields = [];
    _attributes = [];
};
class Lambda {
    _fields = ["args", "body"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(args, body) {
        var self = this;
        self.args = args;
        self.body = body;
    };
};
class IfExp {
    _fields = ["test", "body", "orelse"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(test, body, orelse) {
        var self = this;
        self.test = test;
        self.body = body;
        self.orelse = orelse;
    };
};
class Dict {
    _fields = ["keys", "values"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(keys, values) {
        var self = this;
        self.keys = keys;
        self.values = values;
    };
};
class Set {
    _fields = ["elts"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(elts) {
        var self = this;
        self.elts = elts;
    };
};
class ListComp {
    _fields = ["elt", "generators"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(elt, generators) {
        var self = this;
        self.elt = elt;
        self.generators = generators;
    };
};
class SetComp {
    _fields = ["elt", "generators"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(elt, generators) {
        var self = this;
        self.elt = elt;
        self.generators = generators;
    };
};
class DictComp {
    _fields = ["key", "value", "generators"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(key, value, generators) {
        var self = this;
        self.key = key;
        self.value = value;
        self.generators = generators;
    };
};
class comprehension {
    _fields = ["target", "iter", "ifs", "is_async"];
    _attributes = [];
    constructor(target, iter, ifs, is_async) {
        var self = this;
        self.target = target;
        self.iter = iter;
        self.ifs = ifs;
        self.is_async = is_async;
    };
};
class GeneratorExp {
    _fields = ["elt", "generators"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(elt, generators) {
        var self = this;
        self.elt = elt;
        self.generators = generators;
    };
};
class Await {
    _fields = ["value"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(value) {
        var self = this;
        self.value = value;
    };
};
class Yield {
    _fields = ["value"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(value) {
        var self = this;
        self.value = value;
    };
};
class YieldFrom {
    _fields = ["value"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(value) {
        var self = this;
        self.value = value;
    };
};
class Compare {
    _fields = ["left", "ops", "comparators"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(left, ops, comparators) {
        var self = this;
        self.left = left;
        self.ops = ops;
        self.comparators = comparators;
    };
};
class cmpop {
    _fields = [];
    _attributes = [];
};
class Eq {
    _fields = [];
    _attributes = [];
};
class NotEq {
    _fields = [];
    _attributes = [];
};
class Lt {
    _fields = [];
    _attributes = [];
};
class LtE {
    _fields = [];
    _attributes = [];
};
class Gt {
    _fields = [];
    _attributes = [];
};
class GtE {
    _fields = [];
    _attributes = [];
};
class Is {
    _fields = [];
    _attributes = [];
};
class IsNot {
    _fields = [];
    _attributes = [];
};
class In {
    _fields = [];
    _attributes = [];
};
class NotIn {
    _fields = [];
    _attributes = [];
};
class Call {
    _fields = ["func", "args", "keywords"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(func, args, keywords) {
        var self = this;
        self.func = func;
        self.args = args;
        self.keywords = keywords;
    };
};
class keyword {
    _fields = ["arg", "value"];
    _attributes = [];
    constructor(arg, value) {
        var self = this;
        self.arg = arg;
        self.value = value;
    };
};
class FormattedValue {
    _fields = ["value", "conversion", "format_spec"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(value, conversion, format_spec) {
        var self = this;
        self.value = value;
        self.conversion = conversion;
        self.format_spec = format_spec;
    };
};
class JoinedStr {
    _fields = ["values"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(values) {
        var self = this;
        self.values = values;
    };
};
class Constant {
    _fields = ["value", "kind"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(value, kind) {
        var self = this;
        self.value = value;
        self.kind = kind;
    };
};
class Attribute {
    _fields = ["value", "attr", "ctx"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(value, attr, ctx) {
        var self = this;
        self.value = value;
        self.attr = attr;
        self.ctx = ctx;
    };
};
class Subscript {
    _fields = ["value", "slice", "ctx"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(value, slice, ctx) {
        var self = this;
        self.value = value;
        self.slice = slice;
        self.ctx = ctx;
    };
};
class slice {
    _fields = [];
    _attributes = [];
};
class Slice {
    _fields = ["lower", "upper", "step"];
    _attributes = [];
    constructor(lower, upper, step) {
        var self = this;
        self.lower = lower;
        self.upper = upper;
        self.step = step;
    };
};
class ExtSlice {
    _fields = ["dims"];
    _attributes = [];
    constructor(dims) {
        var self = this;
        self.dims = dims;
    };
};
class Index {
    _fields = ["value"];
    _attributes = [];
    constructor(value) {
        var self = this;
        self.value = value;
    };
};
class Starred {
    _fields = ["value", "ctx"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(value, ctx) {
        var self = this;
        self.value = value;
        self.ctx = ctx;
    };
};
class Name {
    _fields = ["id", "ctx"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(id, ctx) {
        var self = this;
        self.id = id;
        self.ctx = ctx;
    };
};
class List {
    _fields = ["elts", "ctx"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(elts, ctx) {
        var self = this;
        self.elts = elts;
        self.ctx = ctx;
    };
};
class Tuple {
    _fields = ["elts", "ctx"];
    _attributes = ["lineno", "col_offset", "end_lineno", "end_col_offset"];
    constructor(elts, ctx) {
        var self = this;
        self.elts = elts;
        self.ctx = ctx;
    };
};
var PyCF_ONLY_AST = 1024;
var PyCF_TYPE_COMMENTS = 4096;
var PyCF_ALLOW_TOP_LEVEL_AWAIT = 8192;

function set_end_ast(ast, end_ast) {
    return set_end(ast, end_ast.end_lineno, end_ast.end_col_offset);
};

function set_ctx(targets, ctx) {
    for (const g5 in [...Array(targets.length).keys()]) {
        var t = targets[g5];
        t.ctx = ctx;
        if ((t instanceof Tuple)) {
            for (const g6 in [...Array(t.elts.length).keys()]) {
                t.elts[g6].ctx = ctx;
            };
        };
    };
};

function parse_file_input(ts) {
    var stmts1 = parse_stmts(ts);
    if ((ts.token === ENDMARKER)) {
        advance(ts);
    } else {
        return syntax_error(ts);
    };
    return new Module(stmts1, []);
};

function parse_stmts(ts) {
    var asts = [];
    while ([NAME, NUMBER, STRING, NEWLINE, LPAR, LSQB, PLUS, MINUS, STAR, LBRACE, TILDE, ELLIPSIS, FALSE, NONE, TRUE, ASSERT, BREAK, CONTINUE, DEF, DEL, FOR, GLOBAL, IF, IMPORT, LAMBDA, NONLOCAL, NOT, PASS, RAISE, RETURN, WHILE, YIELD, AWAIT].indexOf(ts.token) >= 0) {
        if ((ts.token === NEWLINE)) {
            advance(ts);
        } else {
            var stmt1 = parse_stmt(ts);
            asts.push(stmt1);
        };
    };
    return asts;
};

function parse_stmt(ts) {
    if ([NAME, NUMBER, STRING, LPAR, LSQB, PLUS, MINUS, STAR, LBRACE, TILDE, ELLIPSIS, FALSE, NONE, TRUE, ASSERT, BREAK, CONTINUE, DEL, GLOBAL, IMPORT, LAMBDA, NONLOCAL, NOT, PASS, RAISE, RETURN, YIELD, AWAIT].indexOf(ts.token) >= 0) {
        var simple_stmt1 = parse_simple_stmt(ts);
        return simple_stmt1;
    } else {
        if ([DEF, IF, WHILE, FOR].indexOf(ts.token) >= 0) {
            var compound_stmt1 = parse_compound_stmt(ts);
            return compound_stmt1;
        } else {
            return syntax_error(ts);
        };
    };
};

function parse_simple_stmt(ts) {
    if ([NAME, NUMBER, STRING, LPAR, LSQB, PLUS, MINUS, STAR, LBRACE, TILDE, ELLIPSIS, FALSE, NONE, TRUE, ASSERT, BREAK, CONTINUE, DEL, GLOBAL, IMPORT, LAMBDA, NONLOCAL, NOT, PASS, RAISE, RETURN, YIELD, AWAIT].indexOf(ts.token) >= 0) {
        var small_stmt1 = parse_small_stmt(ts);
        if ((ts.token === NEWLINE)) {
            advance(ts);
        } else {
            return syntax_error(ts);
        };
        return small_stmt1;
    } else {
        return syntax_error(ts);
    };
};

function parse_compound_stmt(ts) {
    if ((ts.token === IF)) {
        var if_stmt1 = parse_if_stmt(ts);
        return if_stmt1;
    } else {
        if ((ts.token === WHILE)) {
            var while_stmt1 = parse_while_stmt(ts);
            return while_stmt1;
        } else {
            if ((ts.token === FOR)) {
                var for_stmt1 = parse_for_stmt(ts);
                return for_stmt1;
            } else {
                if ((ts.token === DEF)) {
                    var funcdef1 = parse_funcdef(ts);
                    return funcdef1;
                } else {
                    return syntax_error(ts);
                };
            };
        };
    };
};

function parse_small_stmt(ts) {
    if ([TILDE, NAME, NUMBER, STRING, LBRACE, TRUE, LPAR, LSQB, PLUS, MINUS, NOT, LAMBDA, STAR, ELLIPSIS, FALSE, NONE, AWAIT].indexOf(ts.token) >= 0) {
        var expr_stmt1 = parse_expr_stmt(ts);
        return expr_stmt1;
    } else {
        if ((ts.token === DEL)) {
            var del_stmt1 = parse_del_stmt(ts);
            return del_stmt1;
        } else {
            if ((ts.token === PASS)) {
                var pass_stmt1 = parse_pass_stmt(ts);
                return pass_stmt1;
            } else {
                if ([CONTINUE, RAISE, RETURN, YIELD, BREAK].indexOf(ts.token) >= 0) {
                    var flow_stmt1 = parse_flow_stmt(ts);
                    return flow_stmt1;
                } else {
                    if ((ts.token === IMPORT)) {
                        var import_stmt1 = parse_import_stmt(ts);
                        return import_stmt1;
                    } else {
                        if ((ts.token === GLOBAL)) {
                            var global_stmt1 = parse_global_stmt(ts);
                            return global_stmt1;
                        } else {
                            if ((ts.token === NONLOCAL)) {
                                var nonlocal_stmt1 = parse_nonlocal_stmt(ts);
                                return nonlocal_stmt1;
                            } else {
                                if ((ts.token === ASSERT)) {
                                    var assert_stmt1 = parse_assert_stmt(ts);
                                    return assert_stmt1;
                                } else {
                                    return syntax_error(ts);
                                };
                            };
                        };
                    };
                };
            };
        };
    };
};

function parse_if_stmt(ts) {
    if ((ts.token === IF)) {
        var lineno = get_lineno(ts);
        var col_offset = get_col_offset(ts);
        advance(ts);
        var namedexpr_test1 = parse_namedexpr_test(ts);
        if ((ts.token === COLON)) {
            advance(ts);
        } else {
            return syntax_error(ts);
        };
        var suite1 = parse_suite(ts);
        var branches = [
            [lineno, col_offset, namedexpr_test1, suite1]
        ];
        while ((ts.token === ELIF)) {
            var lineno = get_lineno(ts);
            var col_offset = get_col_offset(ts);
            advance(ts);
            var namedexpr_test2 = parse_namedexpr_test(ts);
            if ((ts.token === COLON)) {
                advance(ts);
            } else {
                return syntax_error(ts);
            };
            var suite2 = parse_suite(ts);
            branches.push([lineno, col_offset, namedexpr_test2, suite2]);
        };
        var orelse = [];
        if ((ts.token === ELSE)) {
            advance(ts);
            if ((ts.token === COLON)) {
                advance(ts);
            } else {
                return syntax_error(ts);
            };
            var suite3 = parse_suite(ts);
            var orelse = suite3;
        };
        while (true) {
            var branch = branches.pop();
            var lineno = branch[0];
            var col_offset = branch[1];
            var test = branch[2];
            var body = branch[3];
            var ast = new If(test, body, orelse);
            set_start(ast, lineno, col_offset);
            set_end_ast(ast, ((orelse.length > 0) ? orelse : body).slice((-(1)))[0]);
            if ((branches.length > 0)) {
                var orelse = [ast];
            } else {
                return ast;
            };
        };
    } else {
        return syntax_error(ts);
    };
};

function parse_while_stmt(ts) {
    if ((ts.token === WHILE)) {
        var lineno = get_lineno(ts);
        var col_offset = get_col_offset(ts);
        advance(ts);
        var namedexpr_test1 = parse_namedexpr_test(ts);
        if ((ts.token === COLON)) {
            advance(ts);
        } else {
            return syntax_error(ts);
        };
        var suite1 = parse_suite(ts);
        var suite2 = [];
        if ((ts.token === ELSE)) {
            advance(ts);
            if ((ts.token === COLON)) {
                advance(ts);
            } else {
                return syntax_error(ts);
            };
            var suite2 = parse_suite(ts);
        };
        var ast = new While(namedexpr_test1, suite1, suite2);
        set_start(ast, lineno, col_offset);
        set_end_ast(ast, ((suite2.length > 0) ? suite2 : suite1).slice((-(1)))[0]);
        return ast;
    } else {
        return syntax_error(ts);
    };
};

function parse_for_stmt(ts) {
    if ((ts.token === FOR)) {
        var lineno = get_lineno(ts);
        var col_offset = get_col_offset(ts);
        var type_comment = null;
        advance(ts);
        var exprlist1 = parse_exprlist(ts);
        if ((ts.token === IN)) {
            advance(ts);
        } else {
            return syntax_error(ts);
        };
        var testlist1 = parse_testlist(ts);
        if ((ts.token === COLON)) {
            advance(ts);
        } else {
            return syntax_error(ts);
        };
        if ((ts.token === TYPE_COMMENT)) {
            advance(ts);
        };
        var suite1 = parse_suite(ts);
        var suite2 = [];
        if ((ts.token === ELSE)) {
            advance(ts);
            if ((ts.token === COLON)) {
                advance(ts);
            } else {
                return syntax_error(ts);
            };
            var suite2 = parse_suite(ts);
        };
        set_ctx(exprlist1, new Store());
        var ast = new For(exprlist1[0], testlist1, suite1, suite2, type_comment);
        set_start(ast, lineno, col_offset);
        set_end_ast(ast, ((suite2.length > 0) ? suite2 : suite1).slice((-(1)))[0]);
        return ast;
    } else {
        return syntax_error(ts);
    };
};

function parse_funcdef(ts) {
    if ((ts.token === DEF)) {
        var lineno = get_lineno(ts);
        var col_offset = get_col_offset(ts);
        var type_comment = null;
        advance(ts);
        if ((ts.token === NAME)) {
            var name = token(ts);
            advance(ts);
        } else {
            return syntax_error(ts);
        };
        var parameters1 = parse_parameters(ts);
        if ((ts.token === MINUS)) {
            advance(ts);
            var test1 = parse_test(ts);
        };
        if ((ts.token === COLON)) {
            advance(ts);
        } else {
            return syntax_error(ts);
        };
        if ((ts.token === TYPE_COMMENT)) {
            advance(ts);
        };
        var func_body_suite1 = parse_func_body_suite(ts);
        var ast = new FunctionDef(name, parameters1, func_body_suite1, [], null, type_comment);
        set_start(ast, lineno, col_offset);
        set_end_ast(ast, func_body_suite1.slice((-(1)))[0]);
        return ast;
    } else {
        return syntax_error(ts);
    };
};

function parse_expr_stmt(ts) {
    if ([TILDE, NAME, NUMBER, STRING, LBRACE, TRUE, LPAR, LSQB, PLUS, MINUS, NOT, LAMBDA, STAR, ELLIPSIS, FALSE, NONE, AWAIT].indexOf(ts.token) >= 0) {
        var lineno = get_lineno(ts);
        var col_offset = get_col_offset(ts);
        var testlist_star_expr1 = parse_testlist_star_expr(ts);
        var targets = [testlist_star_expr1];
        var type_comment = null;
        if ((ts.token === COLON)) {
            var annassign1 = parse_annassign(ts);
        } else {
            if ([PLUSEQUAL, MINEQUAL, STAREQUAL, SLASHEQUAL, PERCENTEQUAL, AMPEREQUAL, VBAREQUAL, CIRCUMFLEXEQUAL, LEFTSHIFTEQUAL, RIGHTSHIFTEQUAL, DOUBLESTAREQUAL, DOUBLESLASHEQUAL].indexOf(ts.token) >= 0) {
                var augassign1 = parse_augassign(ts);
                if ((ts.token === YIELD)) {
                    var yield_expr1 = parse_yield_expr(ts);
                } else {
                    if ([TILDE, NAME, NUMBER, STRING, LBRACE, AWAIT, LPAR, LSQB, PLUS, MINUS, NOT, LAMBDA, ELLIPSIS, FALSE, NONE, TRUE].indexOf(ts.token) >= 0) {
                        var testlist1 = parse_testlist(ts);
                    } else {
                        return syntax_error(ts);
                    };
                };
            } else {
                if ((ts.token === EQUAL)) {
                    while (true) {
                        advance(ts);
                        if ((ts.token === YIELD)) {
                            var yield_expr2 = parse_yield_expr(ts);
                        } else {
                            if ([TILDE, NAME, NUMBER, STRING, LBRACE, TRUE, LPAR, LSQB, PLUS, MINUS, NOT, LAMBDA, STAR, ELLIPSIS, FALSE, NONE, AWAIT].indexOf(ts.token) >= 0) {
                                var testlist_star_expr2 = parse_testlist_star_expr(ts);
                            } else {
                                return syntax_error(ts);
                            };
                        };
                        if ((!((ts.token === EQUAL)))) {
                            break;
                        };
                    };
                    var ast = new Assign(targets, testlist_star_expr2, type_comment);
                    set_ctx(targets, new Store());
                    return set_start_end(ts, lineno, col_offset, ast);
                    if ((ts.token === TYPE_COMMENT)) {
                        advance(ts);
                    };
                };
                var ast = new Expr(testlist_star_expr1);
                return set_start_end(ts, lineno, col_offset, ast);
            };
        };
    } else {
        return syntax_error(ts);
    };
};

function parse_del_stmt(ts) {
    if ((ts.token === DEL)) {
        var lineno = get_lineno(ts);
        var col_offset = get_col_offset(ts);
        advance(ts);
        var exprlist1 = parse_exprlist(ts);
        var ast = new Delete(exprlist1);
        set_ctx(exprlist1, new Del());
        return set_start_end(ts, lineno, col_offset, ast);
    } else {
        return syntax_error(ts);
    };
};

function parse_pass_stmt(ts) {
    if ((ts.token === PASS)) {
        var ast = set_start_end_1token(ts, new Pass());
        advance(ts);
        return ast;
    } else {
        return syntax_error(ts);
    };
};

function parse_flow_stmt(ts) {
    if ((ts.token === BREAK)) {
        var break_stmt1 = parse_break_stmt(ts);
        return break_stmt1;
    } else {
        if ((ts.token === CONTINUE)) {
            var continue_stmt1 = parse_continue_stmt(ts);
            return continue_stmt1;
        } else {
            if ((ts.token === RETURN)) {
                var return_stmt1 = parse_return_stmt(ts);
                return return_stmt1;
            } else {
                if ((ts.token === RAISE)) {
                    var raise_stmt1 = parse_raise_stmt(ts);
                    return raise_stmt1;
                } else {
                    if ((ts.token === YIELD)) {
                        var yield_stmt1 = parse_yield_stmt(ts);
                        return yield_stmt1;
                    } else {
                        return syntax_error(ts);
                    };
                };
            };
        };
    };
};

function parse_import_stmt(ts) {
    if ((ts.token === IMPORT)) {
        var import_name1 = parse_import_name(ts);
        return import_name1;
    } else {
        return syntax_error(ts);
    };
};

function parse_global_stmt(ts) {
    if ((ts.token === GLOBAL)) {
        var lineno = get_lineno(ts);
        var col_offset = get_col_offset(ts);
        advance(ts);
        if ((ts.token === NAME)) {
            var names = [token(ts)];
            advance(ts);
        } else {
            return syntax_error(ts);
        };
        while ((ts.token === COMMA)) {
            advance(ts);
            if ((ts.token === NAME)) {
                names.push(token(ts));
                advance(ts);
            } else {
                return syntax_error(ts);
            };
        };
        var ast = new Global(names);
        return set_start_end(ts, lineno, col_offset, ast);
    } else {
        return syntax_error(ts);
    };
};

function parse_nonlocal_stmt(ts) {
    if ((ts.token === NONLOCAL)) {
        var lineno = get_lineno(ts);
        var col_offset = get_col_offset(ts);
        advance(ts);
        if ((ts.token === NAME)) {
            var names = [token(ts)];
            advance(ts);
        } else {
            return syntax_error(ts);
        };
        while ((ts.token === COMMA)) {
            advance(ts);
            if ((ts.token === NAME)) {
                names.push(token(ts));
                advance(ts);
            } else {
                return syntax_error(ts);
            };
        };
        var ast = new Nonlocal(names);
        return set_start_end(ts, lineno, col_offset, ast);
    } else {
        return syntax_error(ts);
    };
};

function parse_assert_stmt(ts) {
    if ((ts.token === ASSERT)) {
        var lineno = get_lineno(ts);
        var col_offset = get_col_offset(ts);
        advance(ts);
        var test1 = parse_test(ts);
        var msg = null;
        if ((ts.token === COMMA)) {
            advance(ts);
            var test2 = parse_test(ts);
            var msg = test2;
        };
        var ast = new Assert(test1, msg);
        return set_start_end(ts, lineno, col_offset, ast);
    } else {
        return syntax_error(ts);
    };
};

function parse_namedexpr_test(ts) {
    if ([TILDE, NAME, NUMBER, STRING, LBRACE, AWAIT, LPAR, LSQB, PLUS, MINUS, NOT, LAMBDA, ELLIPSIS, FALSE, NONE, TRUE].indexOf(ts.token) >= 0) {
        var lineno = get_lineno(ts);
        var col_offset = get_col_offset(ts);
        var test1 = parse_test(ts);
        var test2 = null;
        if (Object.is(test2, null)) {
            return test1;
        } else {
            return test2;
        };
    } else {
        return syntax_error(ts);
    };
};

function parse_suite(ts) {
    if ([NAME, NUMBER, STRING, LPAR, LSQB, PLUS, MINUS, STAR, LBRACE, TILDE, ELLIPSIS, FALSE, NONE, TRUE, ASSERT, BREAK, CONTINUE, DEL, GLOBAL, IMPORT, LAMBDA, NONLOCAL, NOT, PASS, RAISE, RETURN, YIELD, AWAIT].indexOf(ts.token) >= 0) {
        var simple_stmt1 = parse_simple_stmt(ts);
    } else {
        if ((ts.token === NEWLINE)) {
            advance(ts);
            if ((ts.token === INDENT)) {
                advance(ts);
            } else {
                return syntax_error(ts);
            };
            var stmts = [];
            while (true) {
                var stmt1 = parse_stmt(ts);
                stmts.push(stmt1);
                if ((!([NAME, NUMBER, STRING, LPAR, LSQB, PLUS, MINUS, STAR, LBRACE, TILDE, ELLIPSIS, FALSE, NONE, TRUE, ASSERT, BREAK, CONTINUE, DEF, DEL, FOR, GLOBAL, IF, IMPORT, LAMBDA, NONLOCAL, NOT, PASS, RAISE, RETURN, WHILE, YIELD, AWAIT].indexOf(ts.token) >= 0))) {
                    break;
                };
            };
            if ((ts.token === DEDENT)) {
                advance(ts);
            } else {
                return syntax_error(ts);
            };
            return stmts;
        } else {
            return syntax_error(ts);
        };
    };
};

function parse_exprlist(ts) {
    if ([TILDE, NAME, NUMBER, STRING, TRUE, AWAIT, LPAR, LSQB, PLUS, MINUS, STAR, ELLIPSIS, FALSE, NONE, LBRACE].indexOf(ts.token) >= 0) {
        if ([TILDE, NAME, NUMBER, STRING, TRUE, AWAIT, LPAR, LSQB, PLUS, MINUS, ELLIPSIS, FALSE, NONE, LBRACE].indexOf(ts.token) >= 0) {
            var expr1 = parse_expr(ts);
            var expr_or_star_expr1 = expr1;
        } else {
            var star_expr1 = parse_star_expr(ts);
            var expr_or_star_expr1 = star_expr1;
        };
        var exprs = [expr_or_star_expr1];
        while ((ts.token === COMMA)) {
            advance(ts);
            if ((!([TILDE, NAME, NUMBER, STRING, TRUE, AWAIT, LPAR, LSQB, PLUS, MINUS, STAR, ELLIPSIS, FALSE, NONE, LBRACE].indexOf(ts.token) >= 0))) {
                break;
            };
            if ([TILDE, NAME, NUMBER, STRING, TRUE, AWAIT, LPAR, LSQB, PLUS, MINUS, ELLIPSIS, FALSE, NONE, LBRACE].indexOf(ts.token) >= 0) {
                var expr2 = parse_expr(ts);
                var expr_or_star_expr2 = expr2;
            } else {
                if ((ts.token === STAR)) {
                    var star_expr2 = parse_star_expr(ts);
                    var expr_or_star_expr2 = star_expr2;
                } else {
                    return syntax_error(ts);
                };
            };
        };
        return exprs;
    } else {
        return syntax_error(ts);
    };
};

function parse_testlist(ts) {
    if ([TILDE, NAME, NUMBER, STRING, LBRACE, AWAIT, LPAR, LSQB, PLUS, MINUS, NOT, LAMBDA, ELLIPSIS, FALSE, NONE, TRUE].indexOf(ts.token) >= 0) {
        var lineno = get_lineno(ts);
        var col_offset = get_col_offset(ts);
        var test1 = parse_test(ts);
        var tests = [test1];
        var force_tuple = false;
        while ((ts.token === COMMA)) {
            advance(ts);
            if ((!([TILDE, NAME, NUMBER, STRING, LBRACE, AWAIT, LPAR, LSQB, PLUS, MINUS, NOT, LAMBDA, ELLIPSIS, FALSE, NONE, TRUE].indexOf(ts.token) >= 0))) {
                var force_tuple = true;
                break;
            };
            var test2 = parse_test(ts);
            tests.push(test2);
        };
        if ((((tests.length === 1)) && ((!(force_tuple))))) {
            return test1;
        } else {
            var ast = new Tuple(tests, new Load());
            return set_start_end(ts, lineno, col_offset, ast);
        };
    } else {
        return syntax_error(ts);
    };
};

function parse_parameters(ts) {
    if ((ts.token === LPAR)) {
        advance(ts);
        var typedargslist1 = null;
        if ((ts.token === NAME)) {
            var typedargslist1 = parse_typedargslist(ts);
        };
        if ((ts.token === RPAR)) {
            advance(ts);
        } else {
            return syntax_error(ts);
        };
        if (Object.is(typedargslist1, null)) {
            return new aarguments([], [], null, [], [], null, []);
        } else {
            return typedargslist1;
        };
    } else {
        return syntax_error(ts);
    };
};

function parse_test(ts) {
    if ([TILDE, NAME, NUMBER, STRING, LBRACE, AWAIT, LPAR, LSQB, PLUS, MINUS, NOT, ELLIPSIS, FALSE, NONE, TRUE].indexOf(ts.token) >= 0) {
        var lineno = get_lineno(ts);
        var col_offset = get_col_offset(ts);
        var or_test1 = parse_or_test(ts);
        if ((ts.token === IF)) {
            advance(ts);
            var or_test2 = parse_or_test(ts);
            if ((ts.token === ELSE)) {
                advance(ts);
            } else {
                return syntax_error(ts);
            };
            var test1 = parse_test(ts);
            var ast = new IfExp(or_test2, or_test1, test1);
            return set_start_end(ts, lineno, col_offset, ast);
        };
        return or_test1;
    } else {
        if ((ts.token === LAMBDA)) {
            var lambdef1 = parse_lambdef(ts);
            return lambdef1;
        } else {
            return syntax_error(ts);
        };
    };
};

function parse_func_body_suite(ts) {
    if ([NAME, NUMBER, STRING, LPAR, LSQB, PLUS, MINUS, STAR, LBRACE, TILDE, ELLIPSIS, FALSE, NONE, TRUE, ASSERT, BREAK, CONTINUE, DEL, GLOBAL, IMPORT, LAMBDA, NONLOCAL, NOT, PASS, RAISE, RETURN, YIELD, AWAIT].indexOf(ts.token) >= 0) {
        var simple_stmt1 = parse_simple_stmt(ts);
        return [simple_stmt1];
    } else {
        if ((ts.token === NEWLINE)) {
            advance(ts);
            if ((ts.token === TYPE_COMMENT)) {
                advance(ts);
                if ((ts.token === NEWLINE)) {
                    advance(ts);
                } else {
                    return syntax_error(ts);
                };
            };
            if ((ts.token === INDENT)) {
                advance(ts);
            } else {
                return syntax_error(ts);
            };
            var stmts = [];
            while (true) {
                var stmt1 = parse_stmt(ts);
                stmts.push(stmt1);
                if ((!([NAME, NUMBER, STRING, LPAR, LSQB, PLUS, MINUS, STAR, LBRACE, TILDE, ELLIPSIS, FALSE, NONE, TRUE, ASSERT, BREAK, CONTINUE, DEF, DEL, FOR, GLOBAL, IF, IMPORT, LAMBDA, NONLOCAL, NOT, PASS, RAISE, RETURN, WHILE, YIELD, AWAIT].indexOf(ts.token) >= 0))) {
                    break;
                };
            };
            if ((ts.token === DEDENT)) {
                advance(ts);
            } else {
                return syntax_error(ts);
            };
            return stmts;
        } else {
            return syntax_error(ts);
        };
    };
};

function parse_testlist_star_expr(ts) {
    if ([TILDE, NAME, NUMBER, STRING, LBRACE, TRUE, LPAR, LSQB, PLUS, MINUS, NOT, LAMBDA, STAR, ELLIPSIS, FALSE, NONE, AWAIT].indexOf(ts.token) >= 0) {
        var lineno = get_lineno(ts);
        var col_offset = get_col_offset(ts);
        if ([TILDE, NAME, NUMBER, STRING, LBRACE, AWAIT, LPAR, LSQB, PLUS, MINUS, NOT, LAMBDA, ELLIPSIS, FALSE, NONE, TRUE].indexOf(ts.token) >= 0) {
            var test1 = parse_test(ts);
            var test_or_star_expr1 = test1;
        } else {
            var star_expr1 = parse_star_expr(ts);
            var test_or_star_expr1 = star_expr1;
        };
        var tests = [test_or_star_expr1];
        var force_tuple = false;
        while ((ts.token === COMMA)) {
            advance(ts);
            if ((!([TILDE, NAME, NUMBER, STRING, LBRACE, TRUE, LPAR, LSQB, PLUS, MINUS, NOT, LAMBDA, STAR, ELLIPSIS, FALSE, NONE, AWAIT].indexOf(ts.token) >= 0))) {
                var force_tuple = true;
                break;
            };
            if ([TILDE, NAME, NUMBER, STRING, LBRACE, AWAIT, LPAR, LSQB, PLUS, MINUS, NOT, LAMBDA, ELLIPSIS, FALSE, NONE, TRUE].indexOf(ts.token) >= 0) {
                var test2 = parse_test(ts);
                tests.push(test2);
            } else {
                if ((ts.token === STAR)) {
                    var star_expr2 = parse_star_expr(ts);
                    tests.push(star_expr2);
                } else {
                    return syntax_error(ts);
                };
            };
        };
        if ((((tests.length === 1)) && ((!(force_tuple))))) {
            return test_or_star_expr1;
        } else {
            var ast = new Tuple(tests, new Load());
            return set_start_end(ts, lineno, col_offset, ast);
        };
    } else {
        return syntax_error(ts);
    };
};

function parse_annassign(ts) {
    if ((ts.token === COLON)) {
        advance(ts);
        var test1 = parse_test(ts);
        if ((ts.token === EQUAL)) {
            advance(ts);
            if ((ts.token === YIELD)) {
                var yield_expr1 = parse_yield_expr(ts);
            } else {
                if ([TILDE, NAME, NUMBER, STRING, LBRACE, AWAIT, LPAR, LSQB, PLUS, MINUS, NOT, LAMBDA, ELLIPSIS, FALSE, NONE, TRUE].indexOf(ts.token) >= 0) {
                    var testlist1 = parse_testlist(ts);
                } else {
                    return syntax_error(ts);
                };
            };
        };
    } else {
        return syntax_error(ts);
    };
};

function parse_augassign(ts) {
    if ((ts.token === PLUSEQUAL)) {
        advance(ts);
        return new Add();
    } else {
        if ((ts.token === MINEQUAL)) {
            advance(ts);
            return new Sub();
        } else {
            if ((ts.token === STAREQUAL)) {
                advance(ts);
                return new Mult();
            } else {
                if (false) {
                    advance(ts);
                    return new MatMult();
                } else {
                    if ((ts.token === SLASHEQUAL)) {
                        advance(ts);
                        return new Div();
                    } else {
                        if ((ts.token === PERCENTEQUAL)) {
                            advance(ts);
                            return new Mod();
                        } else {
                            if ((ts.token === AMPEREQUAL)) {
                                advance(ts);
                                return new BitAnd();
                            } else {
                                if ((ts.token === VBAREQUAL)) {
                                    advance(ts);
                                    return new BitOr();
                                } else {
                                    if ((ts.token === CIRCUMFLEXEQUAL)) {
                                        advance(ts);
                                        return new BitXor();
                                    } else {
                                        if ((ts.token === LEFTSHIFTEQUAL)) {
                                            advance(ts);
                                            return new LShift();
                                        } else {
                                            if ((ts.token === RIGHTSHIFTEQUAL)) {
                                                advance(ts);
                                                return new RShift();
                                            } else {
                                                if ((ts.token === DOUBLESTAREQUAL)) {
                                                    advance(ts);
                                                    return new Pow();
                                                } else {
                                                    if ((ts.token === DOUBLESLASHEQUAL)) {
                                                        advance(ts);
                                                        return new FloorDiv();
                                                    } else {
                                                        return syntax_error(ts);
                                                    };
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
        };
    };
};

function parse_yield_expr(ts) {
    if ((ts.token === YIELD)) {
        var lineno = get_lineno(ts);
        var col_offset = get_col_offset(ts);
        advance(ts);
        if ([TILDE, NAME, NUMBER, STRING, LBRACE, TRUE, LPAR, FROM, LSQB, PLUS, MINUS, NOT, LAMBDA, STAR, ELLIPSIS, FALSE, NONE, AWAIT].indexOf(ts.token) >= 0) {
            var yield_arg1 = parse_yield_arg(ts, lineno, col_offset);
            return yield_arg1;
        };
        var ast = new Yield(null);
        return set_start_end(ts, lineno, col_offset, ast);
    } else {
        return syntax_error(ts);
    };
};

function parse_break_stmt(ts) {
    if ((ts.token === BREAK)) {
        var ast = set_start_end_1token(ts, new Break());
        advance(ts);
        return ast;
    } else {
        return syntax_error(ts);
    };
};

function parse_continue_stmt(ts) {
    if ((ts.token === CONTINUE)) {
        var ast = set_start_end_1token(ts, new Continue());
        advance(ts);
        return ast;
    } else {
        return syntax_error(ts);
    };
};

function parse_return_stmt(ts) {
    if ((ts.token === RETURN)) {
        var lineno = get_lineno(ts);
        var col_offset = get_col_offset(ts);
        var value = null;
        advance(ts);
        if ([TILDE, NAME, NUMBER, STRING, LBRACE, TRUE, LPAR, LSQB, PLUS, MINUS, NOT, LAMBDA, STAR, ELLIPSIS, FALSE, NONE, AWAIT].indexOf(ts.token) >= 0) {
            var testlist_star_expr1 = parse_testlist_star_expr(ts);
            var value = testlist_star_expr1;
        };
        var ast = new Return(value);
        return set_start_end(ts, lineno, col_offset, ast);
    } else {
        return syntax_error(ts);
    };
};

function parse_raise_stmt(ts) {
    if ((ts.token === RAISE)) {
        var lineno = get_lineno(ts);
        var col_offset = get_col_offset(ts);
        var exc = null;
        var cause = null;
        advance(ts);
        if ([TILDE, NAME, NUMBER, STRING, LBRACE, AWAIT, LPAR, LSQB, PLUS, MINUS, NOT, LAMBDA, ELLIPSIS, FALSE, NONE, TRUE].indexOf(ts.token) >= 0) {
            var test1 = parse_test(ts);
            var exc = test1;
            if ((ts.token === FROM)) {
                advance(ts);
                var test2 = parse_test(ts);
                var cause = test2;
            };
        };
        var ast = new Raise(exc, cause);
        return set_start_end(ts, lineno, col_offset, ast);
    } else {
        return syntax_error(ts);
    };
};

function parse_yield_stmt(ts) {
    if ((ts.token === YIELD)) {
        var lineno = get_lineno(ts);
        var col_offset = get_col_offset(ts);
        var yield_expr1 = parse_yield_expr(ts);
        var ast = new Expr(yield_expr1);
        return set_start_end(ts, lineno, col_offset, ast);
    } else {
        return syntax_error(ts);
    };
};

function parse_import_name(ts) {
    if ((ts.token === IMPORT)) {
        var lineno = get_lineno(ts);
        var col_offset = get_col_offset(ts);
        advance(ts);
        var dotted_as_names1 = parse_dotted_as_names(ts);
        var ast = new Import(dotted_as_names1);
        return set_start_end(ts, lineno, col_offset, ast);
    } else {
        return syntax_error(ts);
    };
};

function parse_expr(ts) {
    if ([TILDE, NAME, NUMBER, STRING, TRUE, AWAIT, LPAR, LSQB, PLUS, MINUS, ELLIPSIS, FALSE, NONE, LBRACE].indexOf(ts.token) >= 0) {
        var lineno = get_lineno(ts);
        var col_offset = get_col_offset(ts);
        var xor_expr1 = parse_xor_expr(ts);
        var ast = xor_expr1;
        while ((ts.token === VBAR)) {
            advance(ts);
            var xor_expr2 = parse_xor_expr(ts);
            var ast = new BinOp(ast, new BitOr(), xor_expr2);
            set_start_end(ts, lineno, col_offset, ast);
        };
        return ast;
    } else {
        return syntax_error(ts);
    };
};

function parse_star_expr(ts) {
    if ((ts.token === STAR)) {
        var lineno = get_lineno(ts);
        var col_offset = get_col_offset(ts);
        advance(ts);
        var expr1 = parse_expr(ts);
        var ast = new Starred(expr1, new Load());
        return set_start_end(ts, lineno, col_offset, ast);
    } else {
        return syntax_error(ts);
    };
};

function parse_typedargslist(ts) {
    if ((ts.token === NAME)) {
        var a = new arg(token(ts), null, null);
        set_start_end_1token(ts, a);
        var args = [a];
        advance(ts);
        while ((ts.token === COMMA)) {
            advance(ts);
            if ((ts.token === NAME)) {
                var a = new arg(token(ts), null, null);
                set_start_end_1token(ts, a);
                args.push(a);
                advance(ts);
            } else {
                return syntax_error(ts);
            };
        };
        return new aarguments(args, [], null, [], [], null, []);
    } else {
        return syntax_error(ts);
    };
};

function parse_or_test(ts) {
    if ([TILDE, NAME, NUMBER, STRING, LBRACE, AWAIT, LPAR, LSQB, PLUS, MINUS, NOT, ELLIPSIS, FALSE, NONE, TRUE].indexOf(ts.token) >= 0) {
        var lineno = get_lineno(ts);
        var col_offset = get_col_offset(ts);
        var and_test1 = parse_and_test(ts);
        var asts = [and_test1];
        while ((ts.token === OR)) {
            advance(ts);
            var and_test2 = parse_and_test(ts);
            asts.push(and_test2);
        };
        if ((asts.length === 1)) {
            return asts[0];
        } else {
            var ast = new BoolOp(new Or(), asts);
            return set_start_end(ts, lineno, col_offset, ast);
        };
    } else {
        return syntax_error(ts);
    };
};

function parse_lambdef(ts) {
    if ((ts.token === LAMBDA)) {
        var lineno = get_lineno(ts);
        var col_offset = get_col_offset(ts);
        var args = null;
        advance(ts);
        if ([TILDE, NAME, NUMBER, STRING, LBRACE, AWAIT, LPAR, LSQB, PLUS, MINUS, NOT, LAMBDA, ELLIPSIS, FALSE, NONE, TRUE].indexOf(ts.token) >= 0) {
            var varargslist1 = parse_varargslist(ts);
            var args = varargslist1;
        };
        if ((ts.token === COLON)) {
            advance(ts);
        } else {
            return syntax_error(ts);
        };
        var test1 = parse_test(ts);
        if (Object.is(args, null)) {
            var args = new aarguments([], [], null, [], [], null, []);
        };
        var ast = new Lambda(args, test1);
        return set_start_end(ts, lineno, col_offset, ast);
    } else {
        return syntax_error(ts);
    };
};

function parse_yield_arg(ts, lineno, col_offset) {
    if ((ts.token === FROM)) {
        advance(ts);
        var test1 = parse_test(ts);
        var ast = new YieldFrom(test1);
        return set_start_end(ts, lineno, col_offset, ast);
    } else {
        if ([TILDE, NAME, NUMBER, STRING, LBRACE, TRUE, LPAR, LSQB, PLUS, MINUS, NOT, LAMBDA, STAR, ELLIPSIS, FALSE, NONE, AWAIT].indexOf(ts.token) >= 0) {
            var testlist_star_expr1 = parse_testlist_star_expr(ts);
            var ast = new Yield(testlist_star_expr1);
            return set_start_end(ts, lineno, col_offset, ast);
        } else {
            return syntax_error(ts);
        };
    };
};

function parse_dotted_as_names(ts) {
    if ((ts.token === NAME)) {
        var lineno = get_lineno(ts);
        var col_offset = get_col_offset(ts);
        var dotted_as_name1 = parse_dotted_as_name(ts);
        var names = [dotted_as_name1];
        while ((ts.token === COMMA)) {
            advance(ts);
            var dotted_as_name2 = parse_dotted_as_name(ts);
            names.push(dotted_as_name2);
        };
        return names;
    } else {
        return syntax_error(ts);
    };
};

function parse_xor_expr(ts) {
    if ([TILDE, NAME, NUMBER, STRING, TRUE, AWAIT, LPAR, LSQB, PLUS, MINUS, ELLIPSIS, FALSE, NONE, LBRACE].indexOf(ts.token) >= 0) {
        var lineno = get_lineno(ts);
        var col_offset = get_col_offset(ts);
        var and_expr1 = parse_and_expr(ts);
        var ast = and_expr1;
        while ((ts.token === CIRCUMFLEX)) {
            advance(ts);
            var and_expr2 = parse_and_expr(ts);
            var ast = new BinOp(ast, new BitXor(), and_expr2);
            set_start_end(ts, lineno, col_offset, ast);
        };
        return ast;
    } else {
        return syntax_error(ts);
    };
};

function parse_and_test(ts) {
    if ([TILDE, NAME, NUMBER, STRING, LBRACE, AWAIT, LPAR, LSQB, PLUS, MINUS, NOT, ELLIPSIS, FALSE, NONE, TRUE].indexOf(ts.token) >= 0) {
        var lineno = get_lineno(ts);
        var col_offset = get_col_offset(ts);
        var not_test1 = parse_not_test(ts);
        var asts = [not_test1];
        while ((ts.token === AND)) {
            advance(ts);
            var not_test2 = parse_not_test(ts);
            asts.push(not_test2);
        };
        if ((asts.length === 1)) {
            return asts[0];
        } else {
            var ast = new BoolOp(new And(), asts);
            return set_start_end(ts, lineno, col_offset, ast);
        };
    } else {
        return syntax_error(ts);
    };
};

function parse_varargslist(ts) {
    if ([TILDE, NAME, NUMBER, STRING, LBRACE, AWAIT, LPAR, LSQB, PLUS, MINUS, NOT, LAMBDA, ELLIPSIS, FALSE, NONE, TRUE].indexOf(ts.token) >= 0) {
        var arglist1 = parse_arglist(ts);
    } else {
        return syntax_error(ts);
    };
};

function parse_dotted_as_name(ts) {
    if ((ts.token === NAME)) {
        var dotted_name1 = parse_dotted_name(ts);
        var asname = null;
        if ((ts.token === AS)) {
            advance(ts);
            if ((ts.token === NAME)) {
                var asname = token(ts);
                advance(ts);
            } else {
                return syntax_error(ts);
            };
        };
        return new alias(dotted_name1, asname);
    } else {
        return syntax_error(ts);
    };
};

function parse_and_expr(ts) {
    if ([TILDE, NAME, NUMBER, STRING, TRUE, AWAIT, LPAR, LSQB, PLUS, MINUS, ELLIPSIS, FALSE, NONE, LBRACE].indexOf(ts.token) >= 0) {
        var lineno = get_lineno(ts);
        var col_offset = get_col_offset(ts);
        var shift_expr1 = parse_shift_expr(ts);
        var ast = shift_expr1;
        while ((ts.token === AMPER)) {
            advance(ts);
            var shift_expr2 = parse_shift_expr(ts);
            var ast = new BinOp(ast, new BitAnd(), shift_expr2);
            set_start_end(ts, lineno, col_offset, ast);
        };
        return ast;
    } else {
        return syntax_error(ts);
    };
};

function parse_not_test(ts) {
    if ((ts.token === NOT)) {
        var lineno = get_lineno(ts);
        var col_offset = get_col_offset(ts);
        advance(ts);
        var not_test1 = parse_not_test(ts);
        var ast = new UnaryOp(new Not(), not_test1);
        return set_start_end(ts, lineno, col_offset, ast);
    } else {
        if ([TILDE, NAME, NUMBER, STRING, TRUE, AWAIT, LPAR, LSQB, PLUS, MINUS, ELLIPSIS, FALSE, NONE, LBRACE].indexOf(ts.token) >= 0) {
            var comparison1 = parse_comparison(ts);
            return comparison1;
        } else {
            return syntax_error(ts);
        };
    };
};

function parse_arglist(ts) {
    if ([TILDE, NAME, NUMBER, STRING, LBRACE, AWAIT, LPAR, LSQB, PLUS, MINUS, NOT, LAMBDA, ELLIPSIS, FALSE, NONE, TRUE].indexOf(ts.token) >= 0) {
        var argument1 = parse_argument(ts);
        var args = [argument1];
        while ((ts.token === COMMA)) {
            advance(ts);
            if ((!([TILDE, NAME, NUMBER, STRING, LBRACE, AWAIT, LPAR, LSQB, PLUS, MINUS, NOT, LAMBDA, ELLIPSIS, FALSE, NONE, TRUE].indexOf(ts.token) >= 0))) {
                break;
            };
            var argument2 = parse_argument(ts);
            args.push(argument2);
        };
        return args;
    } else {
        return syntax_error(ts);
    };
};

function parse_dotted_name(ts) {
    if ((ts.token === NAME)) {
        var dotted_name = token(ts);
        advance(ts);
        while ((ts.token === DOT)) {
            advance(ts);
            if ((ts.token === NAME)) {
                var dotted_name = ((dotted_name + ".") + token(ts));
                advance(ts);
            } else {
                return syntax_error(ts);
            };
        };
        return dotted_name;
    } else {
        return syntax_error(ts);
    };
};

function parse_shift_expr(ts) {
    if ([TILDE, NAME, NUMBER, STRING, TRUE, AWAIT, LPAR, LSQB, PLUS, MINUS, ELLIPSIS, FALSE, NONE, LBRACE].indexOf(ts.token) >= 0) {
        var lineno = get_lineno(ts);
        var col_offset = get_col_offset(ts);
        var arith_expr1 = parse_arith_expr(ts);
        var ast = arith_expr1;
        while ([LEFTSHIFT, RIGHTSHIFT].indexOf(ts.token) >= 0) {
            if ((ts.token === LEFTSHIFT)) {
                var op = new LShift();
            } else {
                var op = new RShift();
            };
            advance(ts);
            var arith_expr2 = parse_arith_expr(ts);
            var ast = new BinOp(ast, op, arith_expr2);
            set_start_end(ts, lineno, col_offset, ast);
        };
        return ast;
    } else {
        return syntax_error(ts);
    };
};

function parse_comparison(ts) {
    if ([TILDE, NAME, NUMBER, STRING, TRUE, AWAIT, LPAR, LSQB, PLUS, MINUS, ELLIPSIS, FALSE, NONE, LBRACE].indexOf(ts.token) >= 0) {
        var lineno = get_lineno(ts);
        var col_offset = get_col_offset(ts);
        var expr1 = parse_expr(ts);
        var ops = [];
        var comparators = [];
        while ([IN, IS, NOT, LESS, GREATER, EQEQUAL, NOTEQUAL, LESSEQUAL, GREATEREQUAL].indexOf(ts.token) >= 0) {
            var comp_op1 = parse_comp_op(ts);
            var expr2 = parse_expr(ts);
            ops.push(comp_op1);
            comparators.push(expr2);
        };
        if ((ops.length === 0)) {
            return expr1;
        } else {
            var ast = new Compare(expr1, ops, comparators);
            return set_start_end(ts, lineno, col_offset, ast);
        };
    } else {
        return syntax_error(ts);
    };
};

function parse_argument(ts) {
    if ([TILDE, NAME, NUMBER, STRING, LBRACE, AWAIT, LPAR, LSQB, PLUS, MINUS, NOT, LAMBDA, ELLIPSIS, FALSE, NONE, TRUE].indexOf(ts.token) >= 0) {
        var test1 = parse_test(ts);
        return test1;
    } else {
        return syntax_error(ts);
    };
};

function parse_arith_expr(ts) {
    if ([TILDE, NAME, NUMBER, STRING, TRUE, AWAIT, LPAR, LSQB, PLUS, MINUS, ELLIPSIS, FALSE, NONE, LBRACE].indexOf(ts.token) >= 0) {
        var lineno = get_lineno(ts);
        var col_offset = get_col_offset(ts);
        var term1 = parse_term(ts);
        var ast = term1;
        while ([PLUS, MINUS].indexOf(ts.token) >= 0) {
            if ((ts.token === PLUS)) {
                var op = new Add();
            } else {
                var op = new Sub();
            };
            advance(ts);
            var term2 = parse_term(ts);
            var ast = new BinOp(ast, op, term2);
            set_start_end(ts, lineno, col_offset, ast);
        };
        return ast;
    } else {
        return syntax_error(ts);
    };
};

function parse_comp_op(ts) {
    if ((ts.token === LESS)) {
        advance(ts);
        return new Lt();
    } else {
        if ((ts.token === GREATER)) {
            advance(ts);
            return new Gt();
        } else {
            if ((ts.token === EQEQUAL)) {
                advance(ts);
                return new Eq();
            } else {
                if ((ts.token === GREATEREQUAL)) {
                    advance(ts);
                    return new GtE();
                } else {
                    if ((ts.token === LESSEQUAL)) {
                        advance(ts);
                        return new LtE();
                    } else {
                        if ((ts.token === NOTEQUAL)) {
                            advance(ts);
                            return new NotEq();
                        } else {
                            if (false) {
                                advance(ts);
                                return new NotEq();
                            } else {
                                if ((ts.token === IN)) {
                                    advance(ts);
                                    return new In();
                                } else {
                                    if ((ts.token === NOT)) {
                                        advance(ts);
                                        if ((ts.token === IN)) {
                                            advance(ts);
                                        } else {
                                            return syntax_error(ts);
                                        };
                                        return new NotIn();
                                    } else {
                                        if ((ts.token === IS)) {
                                            advance(ts);
                                            if ((ts.token === NOT)) {
                                                advance(ts);
                                                return new IsNot();
                                            };
                                            return new Is();
                                        } else {
                                            return syntax_error(ts);
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
        };
    };
};

function parse_term(ts) {
    if ([TILDE, NAME, NUMBER, STRING, TRUE, AWAIT, LPAR, LSQB, PLUS, MINUS, ELLIPSIS, FALSE, NONE, LBRACE].indexOf(ts.token) >= 0) {
        var lineno = get_lineno(ts);
        var col_offset = get_col_offset(ts);
        var factor1 = parse_factor(ts);
        var ast = factor1;
        while ([STAR, SLASH, AT, DOUBLESLASH, PERCENT].indexOf(ts.token) >= 0) {
            if ((ts.token === STAR)) {
                var op = new Mult();
            } else {
                if ((ts.token === SLASH)) {
                    var op = new Div();
                } else {
                    if ((ts.token === AT)) {
                        var op = new MatMult();
                    } else {
                        if ((ts.token === DOUBLESLASH)) {
                            var op = new FloorDiv();
                        } else {
                            var op = new Mod();
                        };
                    };
                };
            };
            advance(ts);
            var factor2 = parse_factor(ts);
            var ast = new BinOp(ast, op, factor2);
            set_start_end(ts, lineno, col_offset, ast);
        };
        return ast;
    } else {
        return syntax_error(ts);
    };
};

function parse_factor(ts) {
    if ([TILDE, PLUS, MINUS].indexOf(ts.token) >= 0) {
        var lineno = get_lineno(ts);
        var col_offset = get_col_offset(ts);
        if ((ts.token === PLUS)) {
            var op = new UAdd();
        } else {
            if ((ts.token === MINUS)) {
                var op = new USub();
            } else {
                var op = new Invert();
            };
        };
        advance(ts);
        var factor1 = parse_factor(ts);
        var ast = new UnaryOp(op, factor1);
        return set_start_end(ts, lineno, col_offset, ast);
    } else {
        if ([NAME, NUMBER, STRING, LBRACE, AWAIT, LPAR, LSQB, ELLIPSIS, FALSE, NONE, TRUE].indexOf(ts.token) >= 0) {
            var power1 = parse_power(ts);
            return power1;
        } else {
            return syntax_error(ts);
        };
    };
};

function parse_power(ts) {
    if ([NAME, NUMBER, STRING, LBRACE, AWAIT, LPAR, LSQB, ELLIPSIS, FALSE, NONE, TRUE].indexOf(ts.token) >= 0) {
        var lineno = get_lineno(ts);
        var col_offset = get_col_offset(ts);
        var atom_expr1 = parse_atom_expr(ts);
        if ((ts.token === DOUBLESTAR)) {
            advance(ts);
            var factor1 = parse_factor(ts);
            var ast = new BinOp(atom_expr1, new Pow(), factor1);
            return set_start_end(ts, lineno, col_offset, ast);
        };
        return atom_expr1;
    } else {
        return syntax_error(ts);
    };
};

function parse_atom_expr(ts) {
    if ([NAME, NUMBER, STRING, LBRACE, AWAIT, LPAR, LSQB, ELLIPSIS, FALSE, NONE, TRUE].indexOf(ts.token) >= 0) {
        var lineno = get_lineno(ts);
        var col_offset = get_col_offset(ts);
        var has_await = false;
        if ((ts.token === AWAIT)) {
            var has_await = true;
            advance(ts);
        };
        var atom1 = parse_atom(ts);
        var ast = atom1;
        while ([LSQB, LPAR, DOT].indexOf(ts.token) >= 0) {
            var trailer1 = parse_trailer(ts, lineno, col_offset, ast);
            var ast = trailer1;
        };
        if (has_await) {
            var ast = new Await(ast);
            set_start_end(ts, lineno, col_offset, ast);
        };
        return ast;
    } else {
        return syntax_error(ts);
    };
};

function parse_atom(ts) {
    if ((ts.token === LPAR)) {
        advance(ts);
        if ([TILDE, NAME, NUMBER, STRING, LBRACE, FALSE, TRUE, LPAR, LSQB, PLUS, MINUS, NOT, LAMBDA, ELLIPSIS, YIELD, NONE, AWAIT].indexOf(ts.token) >= 0) {
            if ((ts.token === YIELD)) {
                var yield_expr1 = parse_yield_expr(ts);
                var ast = yield_expr1;
            } else {
                var testlist_comp1 = parse_testlist_comp(ts);
                var ast = testlist_comp1;
            };
        };
        if ((ts.token === RPAR)) {
            advance(ts);
        } else {
            return syntax_error(ts);
        };
        return ast;
    } else {
        if ((ts.token === LSQB)) {
            var lineno = get_lineno(ts);
            var col_offset = get_col_offset(ts);
            advance(ts);
            if ([TILDE, NAME, NUMBER, STRING, LBRACE, AWAIT, LPAR, LSQB, PLUS, MINUS, NOT, LAMBDA, ELLIPSIS, FALSE, NONE, TRUE].indexOf(ts.token) >= 0) {
                var testlist_comp2 = parse_testlist_comp(ts);
            };
            if ((ts.token === RSQB)) {
                advance(ts);
            } else {
                return syntax_error(ts);
            };
        } else {
            if ((ts.token === LBRACE)) {
                var lineno = get_lineno(ts);
                var col_offset = get_col_offset(ts);
                advance(ts);
                if ((ts.token === ELSE)) {
                    var dictorsetmaker1 = parse_dictorsetmaker(ts);
                };
                if ((ts.token === RBRACE)) {
                    advance(ts);
                } else {
                    return syntax_error(ts);
                };
            } else {
                if ((ts.token === NAME)) {
                    var ast = set_start_end_1token(ts, new Name(token(ts), new Load()));
                    advance(ts);
                    return ast;
                } else {
                    if ((ts.token === NUMBER)) {
                        var ast = set_start_end_1token(ts, new Constant(Number(token(ts)), null));
                        advance(ts);
                        return ast;
                    } else {
                        if ((ts.token === STRING)) {
                            var lineno = get_lineno(ts);
                            var col_offset = get_col_offset(ts);
                            var end_lineno = 0;
                            var end_col_offset = 0;
                            var value = "";
                            while (true) {
                                var end_lineno = get_end_lineno(ts);
                                var end_col_offset = get_end_col_offset(ts);
                                value += token(ts).slice(1, (-(1)));
                                advance(ts);
                                if ((!((ts.token === STRING)))) {
                                    break;
                                };
                            };
                            var ast = new Constant(value, null);
                            ast.lineno = lineno;
                            ast.col_offset = col_offset;
                            ast.end_lineno = end_lineno;
                            ast.end_col_offset = end_col_offset;
                            return ast;
                        } else {
                            if ((ts.token === ELLIPSIS)) {
                                var ast = set_start_end_1token(ts, new Constant(ELLIPSIS, null));
                                advance(ts);
                                return ast;
                            } else {
                                if ((ts.token === NONE)) {
                                    var ast = set_start_end_1token(ts, new Constant(null, null));
                                    advance(ts);
                                    return ast;
                                } else {
                                    if ((ts.token === TRUE)) {
                                        var ast = set_start_end_1token(ts, new Constant(true, null));
                                        advance(ts);
                                        return ast;
                                    } else {
                                        if ((ts.token === FALSE)) {
                                            var ast = set_start_end_1token(ts, new Constant(false, null));
                                            advance(ts);
                                            return ast;
                                        } else {
                                            return syntax_error(ts);
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
        };
    };
};

function parse_trailer(ts, lineno, col_offset, ast) {
    if ((ts.token === LPAR)) {
        advance(ts);
        var arglist1 = [];
        if ([TILDE, NAME, NUMBER, STRING, LBRACE, AWAIT, LPAR, LSQB, PLUS, MINUS, NOT, LAMBDA, ELLIPSIS, FALSE, NONE, TRUE].indexOf(ts.token) >= 0) {
            var arglist1 = parse_arglist(ts);
        };
        var ast = new Call(ast, arglist1, []);
        if ((ts.token === RPAR)) {
            advance(ts);
        } else {
            return syntax_error(ts);
        };
        return set_start_end(ts, lineno, col_offset, ast);
    } else {
        if ((ts.token === LSQB)) {
            advance(ts);
            var subscriptlist1 = parse_subscriptlist(ts);
            var ast = new Subscript(ast, new Index(subscriptlist1), new Load());
            if ((ts.token === RSQB)) {
                advance(ts);
            } else {
                return syntax_error(ts);
            };
            return set_start_end(ts, lineno, col_offset, ast);
        } else {
            if ((ts.token === DOT)) {
                advance(ts);
                if ((ts.token === NAME)) {
                    var ast = new Attribute(ast, token(ts), new Load());
                    advance(ts);
                } else {
                    return syntax_error(ts);
                };
                return set_start_end(ts, lineno, col_offset, ast);
            } else {
                return syntax_error(ts);
            };
        };
    };
};

function parse_testlist_comp(ts) {
    if ([TILDE, NAME, NUMBER, STRING, LBRACE, AWAIT, LPAR, LSQB, PLUS, MINUS, NOT, LAMBDA, ELLIPSIS, FALSE, NONE, TRUE].indexOf(ts.token) >= 0) {
        var test1 = parse_test(ts);
        return test1;
    } else {
        return syntax_error(ts);
    };
};

function parse_dictorsetmaker(ts) {
    if ((ts.token === ELSE)) {
        advance(ts);
    } else {
        return syntax_error(ts);
    };
};

function parse_subscriptlist(ts) {
    if ([TILDE, NAME, NUMBER, STRING, LBRACE, AWAIT, LPAR, LSQB, PLUS, MINUS, NOT, LAMBDA, ELLIPSIS, FALSE, NONE, TRUE].indexOf(ts.token) >= 0) {
        var lineno = get_lineno(ts);
        var col_offset = get_col_offset(ts);
        var subscript1 = parse_subscript(ts);
        var subscripts = [subscript1];
        var force_tuple = false;
        while ((ts.token === COMMA)) {
            advance(ts);
            if ((!([TILDE, NAME, NUMBER, STRING, LBRACE, AWAIT, LPAR, LSQB, PLUS, MINUS, NOT, LAMBDA, ELLIPSIS, FALSE, NONE, TRUE].indexOf(ts.token) >= 0))) {
                var force_tuple = true;
                break;
            };
            var subscript2 = parse_subscript(ts);
            subscripts.push(subscript2);
        };
        if ((((subscripts.length === 1)) && ((!(force_tuple))))) {
            return subscript1;
        } else {
            var ast = new Tuple(subscripts, new Load());
            return set_start_end(ts, lineno, col_offset, ast);
        };
    } else {
        return syntax_error(ts);
    };
};

function parse_subscript(ts) {
    if ([TILDE, NAME, NUMBER, STRING, LBRACE, AWAIT, LPAR, LSQB, PLUS, MINUS, NOT, LAMBDA, ELLIPSIS, FALSE, NONE, TRUE].indexOf(ts.token) >= 0) {
        var test1 = parse_test(ts);
        return test1;
    } else {
        return syntax_error(ts);
    };
};

function parse_(source) {
    init_stats();
    var ts = new TokenizerState(source);
    advance(ts);
    if (true) {
        return parse_file_input(ts);
    } else {
        return syntax_error(ts);
    };
};

function syntax_error(ts) {
    var line_num = ts.line_num;
    var line_start = 0;
    var line_end = ts.buf.indexOf("\n", line_start);
    var line = source(ts, line_start, line_end);
    var stripped_line = line.lstrip();
    console.log(((("  File \"" + "unknown.py") + "\", line ") + String((ts.line_num + 1))));
    console.log(("    " + stripped_line));
    console.log((("    " + " ".repeat(((ts.start - line_start) - (line.length - stripped_line.length)))) + "^"));
    throw ("invalid syntax");
};

function advance(ts) {
    ts.prev_end_lineno = get_end_lineno(ts);
    ts.prev_end_col_offset = get_end_col_offset(ts);
    get_token(ts);
};

function tokenset() {
    return elements;
};

function show_token(ts) {
    var t = ts.token;
    var name = tok_name[t];
    if ((((t === NAME)) || ((t === STRING)) || ((t === NUMBER)))) {
        console.log(((name + " ") + token(ts)));
    } else {
        console.log(name);
    };
};

function nocompile(f) {
    return f;
};

function parse(source, filename, mode) {
    return parse_((source + "\n"));
};
```

Which we can now evaluate with `node -i -e "$(< zast.js)"`:

```javascript
> var fs = require('fs');
undefined
> fs.readFile("test1.py", "utf8", function(err, data) { if (err) { return console.log(err); } else { console.log(parse(data)); }});
undefined
> Module {
  _fields: [ 'body', 'type_ignores' ],
  _attributes: [],
  body: [
    Expr {
      _fields: [Array],
      _attributes: [Array],
      value: [Name],
      lineno: 5,
      col_offset: 0,
      end_lineno: 5,
      end_col_offset: 1
    },

...

]}
```
