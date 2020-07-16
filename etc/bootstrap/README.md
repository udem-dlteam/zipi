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
➜  bootstrap git:(zp-dev) ✗ python3 zp.py -f ../../parser/ztokenizer.py
../../parser/ztokenizer.py compiled successfully to ../../parser/ztokenizer.js.
```

Pretty-printed output:

```javascript
"use strict";
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
    }
};

function append_eol(buf) {
    return (buf + (((typeof buf) === "string") ? "\n" : "\n"));
};

function init_stats() {
    var found = new Array(68).fill(0);
    var stats = {};
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
    return [found, stats];
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
    }
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
}

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
                        }
                    }
                }
            };
            if ((c === 35)) {
                while (true) {
                    var c = byte_at(buf, pos);
                    pos += 1;
                    if ((((c === 10)) || ((c === 13)))) {
                        break;
                    }
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
                    if ((ts.indents[(i - 1)] >= col)) {
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
                }
            };
            if ((k === KIND_NEWLINE)) {
                ts.start = (pos - 1);
                if ((((c === 13)) && ((byte_at(buf, pos) === 10)))) {
                    pos += 1;
                };
                ts.line_start = pos;
                ts.line_num += 1;
                if ((pos >= ts.buf_len)) {
                    if ((ts.paren_level === 0)) {
                        ts.end = pos;
                        ts.token = NEWLINE;
                        return null;
                    } else {
                        continue;
                    }
                };
                inc_found(KIND_EOF);
                ts.start = ts.buf_len;
                ts.end = ts.buf_len;
                ts.token = ENDMARKER;
                return null;
            }
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
                        }
                    }
                } else {
                    if ((c === 82)) {
                        if ((ts.start === (pos - 1))) {
                            get_string(ts, (pos + 1), next, PLAIN_STRING, true);
                            return null;
                        }
                    }
                }
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
                }
            };
            inc_found(1);
            ts.end = pos;
            ts.token = kind_to_token[k];
            return null;
        };
        inc_stats("OTHER");
        var next = byte_at(buf, pos);
        if ((k >= KIND_LEFTSHIFTEQUAL)) {
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
                        }
                    }
                };
                if ((k === KIND_DOT)) {
                    inc_stats("k == KIND_DOT");
                    if ((char_kind[next] >= 9)) {
                        while (true) {
                            pos += 1;
                            var next = byte_at(buf, pos);
                            if ((char_kind[next] > 9)) {
                                break;
                            }
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
                        }
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
                                }
                            }
                        };
                        var next = byte_at(buf, pos);
                    };
                    while (true) {
                        var k = char_kind[next];
                        if ((k >= 9)) {
                            {};
                        } else {
                            if ((k === KIND_NAME)) {
                                var k = ((next & 223) - 55);
                            } else {
                                k += 100;
                            }
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
                            if ((k >= 9)) {
                                while (true) {
                                    pos += 1;
                                    var next = byte_at(buf, pos);
                                    var k = char_kind[next];
                                    if ((k > 9)) {
                                        break;
                                    }
                                };
                            }
                        }
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
            }
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
                }
            }
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
            }
        }
    } else {
        if ((kind === BYTE_STRING)) {
            _print("@@@@@@ string with B prefix");
        } else {
            if ((kind === UNICODE_STRING)) {
                _print("@@@@@@ string with U prefix");
            } else {
                _print("@@@@@@ string with no prefix");
            }
        }
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
                }
            }
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
                    }
                }
            }
        };
    };
    ts.end = pos;
    ts.token = STRING;
};
```

Which we can now evaluate in `node`:

```javascript
.load ztokenizer.js
[...]
> var _stats = init_stats();
undefined
> var found = _stats[0];
undefined
> var stats = _stats[1];
undefined
> var ts = new TokenizerState("def foo(x,y):\n    return x+y\n");
undefined
> get_token(ts);
null
> while ((ts.token !== ENDMARKER)) {
...     var t = ts.token;
...     var name = tok_name[t];
...     console.log(name);
...     get_token(ts);
... };
DEF
NAME
LPAR
NAME
COMMA
NAME
RPAR
COLON
null
```

And `show_stats();`:

```javascript
> show_stats();

***** STATISTICS *****

----- CHARACTER KINDS ENCOUNTERED:
0 = KIND_NUMBER
3 = KIND_1
0 = KIND_2
0 = KIND_3
0 = KIND_4
0 = KIND_5
1 = KIND_6
0 = KIND_7
0 = KIND_8
0 = KIND_9
4 = KIND_NAME
0 = KIND_STRING
0 = KIND_DOT
0 = KIND_COMMENT
0 = KIND_CONTINUATION
0 = KIND_WHITESPACE
0 = KIND_NEWLINE
0 = KIND_ERROR
0 = KIND_STAR
0 = KIND_STAREQUAL
0 = KIND_DOUBLESTAR
0 = KIND_DOUBLESTAREQUAL
0 = KIND_SLASH
0 = KIND_SLASHEQUAL
0 = KIND_DOUBLESLASH
0 = KIND_DOUBLESLASHEQUAL
0 = KIND_GREATER
0 = KIND_GREATEREQUAL
0 = KIND_RIGHTSHIFT
0 = KIND_RIGHTSHIFTEQUAL
0 = KIND_LESS
0 = KIND_LESSEQUAL
0 = KIND_LEFTSHIFT
0 = KIND_LEFTSHIFTEQUAL
0 = KIND_PERCENT
0 = KIND_PERCENTEQUAL
0 = KIND_AMPER
0 = KIND_AMPEREQUAL
0 = KIND_VBAR
0 = KIND_VBAREQUAL
0 = KIND_CIRCUMFLEX
0 = KIND_CIRCUMFLEXEQUAL
0 = KIND_EQUAL
0 = KIND_EQEQUAL
0 = KIND_PLUS
0 = KIND_PLUSEQUAL
0 = KIND_MINUS
0 = KIND_MINEQUAL
0 = KIND_NOT
0 = KIND_NOTEQUAL
0 = KIND_AT
0 = KIND_ATEQUAL
0 = KIND_COLON
0 = KIND_COLONEQUAL
0 = KIND_TILDE
0 = KIND_COMMA
0 = KIND_BACKQUOTE
0 = KIND_SEMI
0 = KIND_LPAR
0 = KIND_LSQB
0 = KIND_LBRACE
0 = KIND_RPAR
0 = KIND_RSQB
0 = KIND_RBRACE
0 = KIND_ELLIPSIS
0 = KIND_INDENT
0 = KIND_DEDENT
1 = KIND_EOF

----- DISTRIBUTION OF CHARACTER KINDS TESTED:
1 = bol
8 = not_bol
4 = k == KIND_NAME
3 = k >= KIND_TILDE
2 = k >= KIND_LPAR
1 = k <= KIND_LEFTSHIFTEQUAL
0 = k <= KIND_STRING
0 = k == KIND_STRING
0 = k == KIND_DOT
0 = k == KIND_COMMENT
0 = k == KIND_NEWLINE
0 = k == KIND_CONTINUATION
1 = OTHER
1 = SPECIAL
```
