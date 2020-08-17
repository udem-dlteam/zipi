from ztoken import *
from _runtime import dict_get

#------------------------------------------------------------------------------

# The function byte_at(x,i) reads from x the byte that is at index i.
# The parameter x may be of type "str" (for compatibility with Python
# 2) or of type "bytes" (for compatibility with Python 3).  The use of
# such a function may also simplify the translation of the tokenizer
# to another programming language.

def byte_at(x, i): # returns an integer between 0 and 255
    if type(x) is str:
        return ord(x[i])
    else:
        return x[i]

def append_eol(buf):
    return buf + ('\n' if isinstance(buf, str) else b'\n')

#------------------------------------------------------------------------------

# Dictionary to gather some statistics on frequency of tokens.

# TODO: remove when tokenizer is optimized.

stats = {}
found = [0]*68

def init_stats():

    stats['bol'] = 0
    stats['not_bol'] = 0
    stats['k == KIND_NAME'] = 0
    stats['k >= KIND_TILDE'] = 0
    stats['k >= KIND_LPAR'] = 0
    stats['k <= KIND_LEFTSHIFTEQUAL'] = 0
    stats['k <= KIND_STRING'] = 0
    stats['k == KIND_STRING'] = 0
    stats['k == KIND_DOT'] = 0
    stats['k == KIND_COMMENT'] = 0
    stats['k == KIND_NEWLINE'] = 0
    stats['k == KIND_CONTINUATION'] = 0
    stats['OTHER'] = 0
    stats['SPECIAL'] = 0


def inc_found(index):
    found[index] += 1

def inc_stats(name):
    stats[name] += 1

def show_stats():
    print('\n***** STATISTICS *****')
    print('\n----- CHARACTER KINDS ENCOUNTERED:')
    for i in range(len(found)):
        print(str(found[i]), '=', kind_names[i])
    print('\n----- DISTRIBUTION OF CHARACTER KINDS TESTED:')
    for s in stats:
        print(repr(stats[s]), '=', s)

#------------------------------------------------------------------------------

# Each character is assigned a "kind" to simplify the way characters
# read by the tokenizer are classified.  In particular, the character
# kinds 0 to 9 are for digits '0' to '9'.  So a character kind below
# 10 indicates a digit and it also gives the numerical value of the
# digit.

# The array char_kind defined below maps an integer between 0 and 255
# to the character kind.

KIND_NUMBER           = 0
KIND_NAME             = 10
KIND_STRING           = 11
KIND_DOT              = 12
KIND_COMMENT          = 13
KIND_CONTINUATION     = 14
KIND_WHITESPACE       = 15
KIND_NEWLINE          = 16
KIND_ERROR            = 17
KIND_STAR             = 18
KIND_STAREQUAL        = 19
KIND_DOUBLESTAR       = 20
KIND_DOUBLESTAREQUAL  = 21
KIND_SLASH            = 22
KIND_SLASHEQUAL       = 23
KIND_DOUBLESLASH      = 24
KIND_DOUBLESLASHEQUAL = 25
KIND_GREATER          = 26
KIND_GREATEREQUAL     = 27
KIND_RIGHTSHIFT       = 28
KIND_RIGHTSHIFTEQUAL  = 29
KIND_LESS             = 30
KIND_LESSEQUAL        = 31
KIND_LEFTSHIFT        = 32
KIND_LEFTSHIFTEQUAL   = 33
KIND_PERCENT          = 34
KIND_PERCENTEQUAL     = 35
KIND_AMPER            = 36
KIND_AMPEREQUAL       = 37
KIND_VBAR             = 38
KIND_VBAREQUAL        = 39
KIND_CIRCUMFLEX       = 40
KIND_CIRCUMFLEXEQUAL  = 41
KIND_EQUAL            = 42
KIND_EQEQUAL          = 43
KIND_PLUS             = 44
KIND_PLUSEQUAL        = 45
KIND_MINUS            = 46
KIND_MINEQUAL         = 47
KIND_NOT              = 48   # not an actual token
KIND_NOTEQUAL         = 49
KIND_AT               = 50
KIND_ATEQUAL          = 51   # Python3 only
KIND_COLON            = 52
KIND_COLONEQUAL       = 53   # Python3 only
KIND_TILDE            = 54
KIND_COMMA            = 55
KIND_BACKQUOTE        = 56   # Python2 only
KIND_SEMI             = 57
KIND_LPAR             = 58
KIND_LSQB             = 59
KIND_LBRACE           = 60
KIND_RPAR             = 61
KIND_RSQB             = 62
KIND_RBRACE           = 63
KIND_ELLIPSIS         = 64
KIND_INDENT           = 65
KIND_DEDENT           = 66
KIND_EOF              = 67

BYTE_STRING    = 0
PLAIN_STRING   = 1
UNICODE_STRING = 2

# The array kind_to_token maps token kinds to the integer code that
# identifies that token (defined in ztoken.py).

kind_to_token = [
NUMBER,
NUMBER,
NUMBER,
NUMBER,
NUMBER,
NUMBER,
NUMBER,
NUMBER,
NUMBER,
NUMBER,
NAME,
STRING,
DOT,
999, # COMMENT
999, # CONTINUATION
999, # WHITESPACE
NEWLINE,
ERRORTOKEN,
STAR,
STAREQUAL,
DOUBLESTAR,
DOUBLESTAREQUAL,
SLASH,
SLASHEQUAL,
DOUBLESLASH,
DOUBLESLASHEQUAL,
GREATER,
GREATEREQUAL,
RIGHTSHIFT,
RIGHTSHIFTEQUAL,
LESS,
LESSEQUAL,
LEFTSHIFT,
LEFTSHIFTEQUAL,
PERCENT,
PERCENTEQUAL,
AMPER,
AMPEREQUAL,
VBAR,
VBAREQUAL,
CIRCUMFLEX,
CIRCUMFLEXEQUAL,
EQUAL,
EQEQUAL,
PLUS,
PLUSEQUAL,
MINUS,
MINEQUAL,
999, # NOT,
NOTEQUAL,
AT,
ATEQUAL,
COLON,
COLONEQUAL,
TILDE,
COMMA,
BACKQUOTE,
SEMI,
LPAR,
LSQB,
LBRACE,
RPAR,
RSQB,
RBRACE,
ELLIPSIS,
INDENT,
DEDENT,
ENDMARKER
]

# The array kind_names maps character kinds to their symbolic name, which
# is useful for debugging.

# TODO: remove when tokenizer is debugged.

kind_names = [
'KIND_NUMBER',
'KIND_1',
'KIND_2',
'KIND_3',
'KIND_4',
'KIND_5',
'KIND_6',
'KIND_7',
'KIND_8',
'KIND_9',
'KIND_NAME',
'KIND_STRING',
'KIND_DOT',
'KIND_COMMENT',
'KIND_CONTINUATION',
'KIND_WHITESPACE',
'KIND_NEWLINE',
'KIND_ERROR',
'KIND_STAR',
'KIND_STAREQUAL',
'KIND_DOUBLESTAR',
'KIND_DOUBLESTAREQUAL',
'KIND_SLASH',
'KIND_SLASHEQUAL',
'KIND_DOUBLESLASH',
'KIND_DOUBLESLASHEQUAL',
'KIND_GREATER',
'KIND_GREATEREQUAL',
'KIND_RIGHTSHIFT',
'KIND_RIGHTSHIFTEQUAL',
'KIND_LESS',
'KIND_LESSEQUAL',
'KIND_LEFTSHIFT',
'KIND_LEFTSHIFTEQUAL',
'KIND_PERCENT',
'KIND_PERCENTEQUAL',
'KIND_AMPER',
'KIND_AMPEREQUAL',
'KIND_VBAR',
'KIND_VBAREQUAL',
'KIND_CIRCUMFLEX',
'KIND_CIRCUMFLEXEQUAL',
'KIND_EQUAL',
'KIND_EQEQUAL',
'KIND_PLUS',
'KIND_PLUSEQUAL',
'KIND_MINUS',
'KIND_MINEQUAL',
'KIND_NOT',
'KIND_NOTEQUAL',
'KIND_AT',
'KIND_ATEQUAL',
'KIND_COLON',
'KIND_COLONEQUAL',
'KIND_TILDE',
'KIND_COMMA',
'KIND_BACKQUOTE',
'KIND_SEMI',
'KIND_LPAR',
'KIND_LSQB',
'KIND_LBRACE',
'KIND_RPAR',
'KIND_RSQB',
'KIND_RBRACE',
'KIND_ELLIPSIS',
'KIND_INDENT',
'KIND_DEDENT',
'KIND_EOF'
]

def make_char_kind():

    char_kind = bytearray(256)

    def set_char_kind(code, tok):
        char_kind[code] = tok

    for i in range(256):
        set_char_kind(i, KIND_ERROR)

    for i in range(10):
        set_char_kind(ord('0')+i, i) # 0 .. 9

    for i in range(26):
        set_char_kind(ord('a')+i, KIND_NAME) # a .. z
        set_char_kind(ord('A')+i, KIND_NAME) # A .. Z

    set_char_kind(ord('_'), KIND_NAME)

    set_char_kind(ord('"'), KIND_STRING)
    set_char_kind(ord("'"), KIND_STRING)

    set_char_kind(ord('.'), KIND_DOT)

    set_char_kind(ord('#'), KIND_COMMENT)
    set_char_kind(ord('\\'),KIND_CONTINUATION)

    set_char_kind(ord(' '), KIND_WHITESPACE)
    set_char_kind(ord('\t'),KIND_WHITESPACE)
    set_char_kind(ord('\f'),KIND_WHITESPACE)

    set_char_kind(ord('\n'),KIND_NEWLINE)
    set_char_kind(ord('\r'),KIND_NEWLINE)

    set_char_kind(ord('*'), KIND_STAR)
    set_char_kind(ord('/'), KIND_SLASH)
    set_char_kind(ord('>'), KIND_GREATER)
    set_char_kind(ord('<'), KIND_LESS)

    set_char_kind(ord('%'), KIND_PERCENT)
    set_char_kind(ord('&'), KIND_AMPER)
    set_char_kind(ord('|'), KIND_VBAR)
    set_char_kind(ord('^'), KIND_CIRCUMFLEX)
    set_char_kind(ord('='), KIND_EQUAL)
    set_char_kind(ord('+'), KIND_PLUS)
    set_char_kind(ord('-'), KIND_MINUS) # Python3 should check -> token
    set_char_kind(ord('!'), KIND_NOT) # needs special check to reject lone !
    set_char_kind(ord('@'), KIND_AT) # Python2 doesn't have @=
    set_char_kind(ord(':'), KIND_COLON) # Python2 doesn't have :=

    set_char_kind(ord('~'), KIND_TILDE)
    set_char_kind(ord(','), KIND_COMMA)
    #set_char_kind(ord('`'), KIND_BACKQUOTE) # Python3 doesn't have `
    set_char_kind(ord(';'), KIND_SEMI)
    set_char_kind(ord('('), KIND_LPAR)
    set_char_kind(ord('['), KIND_LSQB)
    set_char_kind(ord('{'), KIND_LBRACE)
    set_char_kind(ord(')'), KIND_RPAR)
    set_char_kind(ord(']'), KIND_RSQB)
    set_char_kind(ord('}'), KIND_RBRACE)

    return char_kind

char_kind = make_char_kind()

#------------------------------------------------------------------------------

# Tokenizer state.

# The tokenizer state contains an array of bytes (the buf field) which
# is the UTF-8 encoded source code.  An end-of-line character is added
# to the end as a sentinel.  This avoids having to frequently test for
# the end of input throughout the tokenizer.
#
# The tokenizer state contains the integer code of the most recently
# read token (the token field) and the start and end index of that token
# (the start and end fields).
#
# The tokenizer also maintains an "indents" stack to verify the validity
# of the source code indentation, and to generate implicit
# INDENT and DEDENT tokens corresponding to the indentation.

class TokenizerState:

    def __init__(self, buf, context):
        self.buf = append_eol(buf)  # add sentinel
        self.buf_len = len(buf)
        self.start = 0
        self.end = 0
        self.token = NEWLINE
        self.line_start = 0
        self.line_num = 1
        self.paren_level = 0
        self.indents = [0]
        self.dedents = 0
        self.python = 2
        self.context = context

def get_lineno(ts):
    return ts.line_num

def get_col_offset(ts):
    return ts.start - ts.line_start

def get_end_lineno(ts):
    return ts.line_num

def get_end_col_offset(ts):
    return ts.end - ts.line_start

def set_start(ast, lineno, col_offset):
    ast.lineno = lineno
    ast.col_offset = col_offset
    return ast

def set_end(ast, end_lineno, end_col_offset):
    ast.end_lineno = end_lineno
    ast.end_col_offset = end_col_offset
    return ast

def set_start_end(ts, lineno, col_offset, ast):
    set_start(ast, lineno, col_offset)
    set_end(ast, ts.prev_end_lineno, ts.prev_end_col_offset)
    return ast

def set_start_1token(ts, ast):
    return set_start(ast, get_lineno(ts), get_col_offset(ts))

def set_end_1token(ts, ast):
    return set_end(ast, get_end_lineno(ts), get_end_col_offset(ts))

def set_start_end_1token(ts, ast):
    return set_end_1token(ts, set_start_1token(ts, ast))

def source(ts, start, end):
    return ts.buf[start:end].decode('utf-8')

def token(ts):
    return source(ts, ts.start, ts.end)

def get_value(ts):
    return ts.value
#------------------------------------------------------------------------------

# The tokenizer.

def get_token(ts):

    # handle delayed dedents

    if ts.dedents > 0:
        ts.dedents -= 1
        ts.token = DEDENT
        return

    buf = ts.buf
    pos = ts.end

    # tokenizer's main loop (this loop is only used for comments and
    # continuation lines)

    while True:

        # skip whitespace and comments

        if pos == ts.line_start and ts.paren_level == 0:

            inc_stats('bol')

            # at start of line we have to handle indents and dedents

            col = 0

            while True:
                c = byte_at(buf, pos)
                pos += 1
                if c == 32: # ' '
                    col += 1
                elif c == 9: # '\t'
                    col = (col//8 + 1)*8
                elif c == 12: # '\f'
                    col = 0
                else:
                    break

            # k = char_kind[c]

            if c == 35: # '#' begins a comment (ignore rest of line)
                while True:
                    c = byte_at(buf, pos)
                    pos += 1
                    if c == 10 or c == 13: # EOL?
                        break

            if c == 10 or c == 13: # EOL?
                if c == 13 and byte_at(buf, pos) == 10: # CR-LF
                    pos += 1
                ts.line_start = pos
                ts.line_num += 1
                if pos < ts.buf_len: # not at end of source?
                    continue # go to top of tokenizer's main loop
                ts.start = ts.buf_len
                ts.end = ts.buf_len
                n = len(ts.indents)-1
                if n > 0:
                    ts.indents = [0]
                    ts.dedents = n-1
                    ts.token = DEDENT
                    return
                inc_found(KIND_EOF)  # .0004
                ts.token = ENDMARKER
                return

            n = len(ts.indents)
            i = n-1

            if ts.indents[i] < col:
                ts.indents.append(col)
                ts.start = ts.line_start;
                ts.end = pos-1
                ts.token = INDENT
                return

            if col < ts.indents[i]:

                while True:
                    if ts.indents[i-1] <= col:
                        break
                    i -= 1

                if ts.indents[i-1] != col:
                    ts.start = ts.line_start;
                    ts.end = pos-1
                    ts.token = ERRORTOKEN
                    return

                ts.indents = ts.indents[:i]
                ts.dedents = n-i-1
                ts.start = ts.line_start;
                ts.end = pos-1
                ts.token = DEDENT
                return

            k = char_kind[c]

        else:

            inc_stats('not_bol')

            # inside parentheses or not at start of line

            while True:
                c = byte_at(buf, pos)
                k = char_kind[c]
                pos += 1
                if k != KIND_WHITESPACE: # ' ' or '\t' or '\f'
                    break

            if k == KIND_NEWLINE: # EOL
                ts.start = pos-1
                if c == 13 and byte_at(buf, pos) == 10: # CR-LF
                    pos += 1
                ts.line_start = pos
                ts.line_num += 1
                if pos <= ts.buf_len: # not at end of source?
                    if ts.paren_level == 0:
                        ts.end = pos
                        ts.token = NEWLINE
                        return
                    else:
                        continue # go to top of tokenizer's main loop
                inc_found(KIND_EOF)  # .0004
                ts.start = ts.buf_len
                ts.end = ts.buf_len
                ts.token = ENDMARKER
                return

        # Use the first character of the token to determine which kind
        # of token it is.  The tests are ordered to check for the most
        # frequent cases first.  An analysis of 200 Python files
        # reveals these are the most frequent first characters:
        #
        #    39%  a letter or '_' (e.g. NAME and b'abc')
        #    27%  single character token (e.g. parentheses, colon and comma)
        #    14%  end-of-line, not counting empty lines or full line comments
        #     7%  first character of token that can end with '=' (e.g. +=)
        #     6%  '.' (lone dot or floating point number)
        #     4%  single or double quote
        #     2%  digit

        ts.start = pos-1

        # check for token starting with a letter or '_'

        if k == KIND_NAME: # 39% of tokens

            inc_stats('k == KIND_NAME')

            while True:
                next = byte_at(buf, pos)
                k = char_kind[next]
                if k > KIND_NAME:
                    # not a letter, digit or '_'
                    break
                pos += 1

            if k == KIND_STRING:
                c = c & 0xdf # turn into upper-case letter
                if c == 66 or c == 85: # check for 'B' and 'U'
                    kind = BYTE_STRING if c == 66 else UNICODE_STRING
                    if ts.start == pos-1:
                        get_string(ts, pos+1, next, kind, False)
                        return
                    if ts.start == pos-2:
                        c2 = byte_at(buf, ts.start+1) & 0xdf
                        if c2 == 82: # check for 'R'
                            get_string(ts, pos+1, next, kind, True)
                            return
                elif c == 82: # check for 'R'
                    if ts.start == pos-1:
                        get_string(ts, pos+1, next, PLAIN_STRING, True)
                        return

            # TODO: check if it is a keyword

            inc_found(KIND_NAME) # .4436
            ts.end = pos
            ts.token = dict_get(kw, source(ts, ts.start, ts.end), NAME)
            return

        # check for simple single char token, such as parentheses, comma and ~

        if k >= KIND_TILDE: # 27% of tokens
            inc_stats('k >= KIND_TILDE')
            if k >= KIND_LPAR: # 58% of single char tokens are parentheses
                inc_stats('k >= KIND_LPAR')
                if k >= KIND_RPAR:
                    ts.paren_level -= 1
                else:
                    ts.paren_level += 1
            inc_found(1) # .3711
            ts.end = pos
            ts.token = kind_to_token[k]
            return

        inc_stats('OTHER')

        # decision tree for less frequent tokens

        next = byte_at(buf, pos) # prefetch next char which is almost always needed

        if k <= KIND_LEFTSHIFTEQUAL:

            inc_stats('k <= KIND_LEFTSHIFTEQUAL')

            if k < KIND_STAR:

                # handle string, number, comment and continuation line

                if k == KIND_NEWLINE: # 14% of tokens
                    inc_stats('k == KIND_NEWLINE')
                    if c == 13 and next == 10: # CR-LF
                        pos += 1
                    ts.line_start = pos
                    if pos > ts.buf_len: # at end of source?
                        ts.start = ts.buf_len
                        ts.end = ts.buf_len
                        ts.token = ENDMARKER
                        return
                    elif ts.paren_level > 0 or ts.token == NEWLINE:
                        continue # go to top of tokenizer's main loop
                    else:
                        ts.end = pos
                        ts.token = NEWLINE
                        return

                if k == KIND_DOT: # 6% of tokens
                    inc_stats('k == KIND_DOT')

                    if char_kind[next] <= 9:
                        while True:
                            pos += 1
                            next = byte_at(buf, pos)
                            if char_kind[next] > 9:
                                break
                        inc_found(KIND_NUMBER)
                        ts.end = pos
                        ts.token = NUMBER
                        return
                    elif next == 46 and byte_at(buf, pos+1) == 46: # '.'
                        inc_found(KIND_ELLIPSIS)
                        ts.end = pos+2
                        ts.token = ELLIPSIS
                        return

                    inc_found(KIND_DOT)
                    ts.end = pos
                    ts.token = DOT
                    return

                if k == KIND_STRING: # 4% of tokens
                    inc_stats('k == KIND_STRING')
                    inc_found(KIND_STRING) # .0524
                    get_string(ts, pos, c, PLAIN_STRING, False)
                    return

                if k < KIND_STRING: # 2% of tokens start with a digit
                    inc_stats('k <= KIND_STRING')

                    base = 10

                    if c == 48: # '0'
                        next = next & 0xdf # turn into upper-case letter
                        if next == 88: # 'X'
                            base = 16
                            pos += 1
                        elif next == 79: # 'O'
                            base = 8
                            pos += 1
                        elif next == 66: # 'B'
                            base = 2
                            pos += 1
                        else:
                            base = 8
                        next = byte_at(buf, pos)

                    while True:
                        k = char_kind[next]
                        if k <= 9: # '0'..'9'
                            pass
                        elif k == KIND_NAME: # hex digit handling
                            k = (next & 0xdf) - 55
                        else:
                            k += 100
                        if k > base:
                            break
                        pos += 1
                        next = byte_at(buf, pos)

                    if k == 21 and ts.python == 2: # check for trailing 'L'
                        pos += 1
                    else:
                        if k == 100+KIND_DOT:
                            pos += 1
                            while True:
                                next = byte_at(buf, pos)
                                k = char_kind[next]
                                if k > 9: # not '0'..'9'
                                    break
                                pos += 1
                        next = next & 0xdf # turn into upper-case letter
                        if next == 69: # 'E'
                            pos += 1
                            next = byte_at(buf, pos)
                            if next == 43 or next == 45: # '+' or '-'
                                pos += 1
                                next = byte_at(buf, pos)
                            k = char_kind[next]
                            if k <= 9: # '0'..'9'
                                while True:
                                    pos += 1
                                    next = byte_at(buf, pos)
                                    k = char_kind[next]
                                    if k > 9:
                                        break

                    inc_found(KIND_NUMBER) # .0268
                    ts.end = pos
                    ts.token = NUMBER
                    return

                if k == KIND_COMMENT: # 0.3% of tokens
                    inc_stats('k == KIND_COMMENT')
                    inc_found(KIND_COMMENT) # .0257
                    while byte_at(buf, pos) != 10: # skip until EOL
                        pos += 1
                    continue # go to top of tokenizer's main loop

                # start of a continuation line (very infrequent)

                inc_stats('k == KIND_CONTINUATION')
                inc_found(KIND_CONTINUATION) # .0006
                if next == 10: # LF
                    pos += 1
                    continue # go to top of tokenizer's main loop
                print('error bad continuation line')
                print('c='+repr(c))
                print('next='+repr(next))
                ts.token = 0 #TODO: fix
                return

            # token starts with a character that can be repeated, e.g. >>=

            # check if the starting character is repeated

            if next == c:
                inc_found(2) # .0016
                k += 2
                pos += 1
                next = byte_at(buf, pos)

        # token is an operator that can end with '=' (7% of tokens)

        inc_stats('SPECIAL')

        if next == 61: # ends with '='?
            inc_found(3) # .0085
            k += 1
            pos += 1
        elif k == KIND_LESS and next == 62: # '<' followed by '>'?
            inc_found(4) # .0000
            k = KIND_NOTEQUAL
            pos += 1
        elif k == KIND_NOT: # lone '!' is an error
            inc_found(5) # .0000
            k = KIND_ERROR
        else:
            inc_found(6) # .0693

        ts.end = pos
        ts.token = kind_to_token[k]
        return

def as_octal(byte):
    if ord('0') <= byte <= ord('7'):
        return byte-48
    return -1

def as_hex(byte):

    if byte >= 48 and byte <= 57: # decimal
        return byte - 48
    if byte >= 65 and byte <= 70: # A-F
        return byte - 55 # (A = 10)
    if byte >= 97 and byte <= 102: # a-f
        return byte - 87 # (a = 10)

    return -1

def get_int_from_escape_no_unicode(buf, pos, ts):
    # TODO : make it a tree
    next = byte_at(buf, pos)
    if next == 92 or next == 39 or next == 34: # \\ \' \"
        ts.end = pos+1
        return next
    elif next == 110: # \n
        ts.end = pos+1
        return 10
    elif next == 116: # \t
        ts.end = pos+1
        return 9
    elif next == 102: # \f
        ts.end = pos+1
        return 12
    elif next == 118: # \v
        ts.end = pos+1
        return 11
    elif next == 97:  # \a
        ts.end = pos+1
        return 7
    elif next == 98:  # \b
        ts.end = pos+1
        return 8
    elif as_octal(next)!=-1: # \ooo where o is an octal
        acc = as_octal(next)
        pos+=1
        octal_val = as_octal(byte_at(buf, pos))
        if octal_val != -1:
            pos+=1
            acc = acc * 8 + octal_val
            octal_val = as_octal(byte_at(buf, pos))
            if octal_val != -1:
                pos+=1
                acc = acc * 8 + octal_val
        ts.end = pos
        return acc
    elif next == 120: # \xXX where XX is a base16 number
        v1 = as_hex(byte_at(buf, pos+1))
        v2 = as_hex(byte_at(buf, pos+2))
        if v1 == -1 or v2 == -1:
            ts.token = ERRORTOKEN
            return -1
        ts.end = pos+3
        return v1 * 16 + v2
    ts.end = pos
    return -1

def byte_escape_character_function(buf, pos, ts):
    code = get_int_from_escape_no_unicode(buf, pos, ts)
    pos = ts.end

    # not found
    if code == -1:
        # default, no escape
        ts.value.append(ord("\\"))
        ts.value.append(byte_at(buf, pos))
        pos+=1
    else:
        ts.value.append(code%256)
    return pos



def string_escape_character_function(buf, pos, ts):
    code = get_int_from_escape_no_unicode(buf, pos, ts)
    pos = ts.end

    #not found
    if code == -1:
        # search for unicode characters
        next = byte_at(buf, pos)
        if next == 117: # \uXXXX
            acc = 0
            for i in range(4):
                hex_val = as_hex(byte_at(buf, pos+1+i))
                if hex_val == -1:
                    ts.token = ERRORTOKEN
                    return -1
                acc = acc * 16 + hex_val
            ts.value+=chr(acc)

            return pos+5
        elif next == 85: # \UXXXXXXXX
            acc = 0
            for i in range(8):
                hex_val = as_hex(byte_at(buf, pos+1+i))
                if hex_val == -1:
                    ts.token = ERRORTOKEN
                    return -1
                acc = acc * 16 + hex_val
            ts.value+=chr(acc)
            return pos+9
        # TODO : \N{NAME} is not supported and will be treated as a non-escape
        else:
            # default escape
            ts.value += "\\"
            ts.value += chr(next)
            return pos+1
    else:
        ts.value += chr(code)
    return pos

def get_string_raw(ts, pos, c, kind):
    buf = ts.buf
    if byte_at(buf, pos) == c and byte_at(buf, pos+1) == c:

        #TODO check end of buffer
        pos += 2
        while True:
            next = byte_at(buf, pos)

            if next == c and byte_at(buf, pos+1) == c and byte_at(buf, pos+2) == c:
                pos += 3
                break

            #add character
            pos+=1
            if kind==BYTE_STRING:
                ts.value.append(next)
            else:
                ts.value += chr(next)

            if next == 92: # '\'
                if byte_at(buf, pos) == 10:
                    ts.line_num += 1
                elif byte_at(buf, pos) == c:
                    if kind == BYTE_STRING:
                        ts.value.append(c)
                    else:
                        ts.value += chr(c)
                    pos+=1
            else:
                if next == 10:
                    ts.line_num += 1

    else:
        while True:
            next = byte_at(buf, pos)
            if next == c:
                pos += 1
                break
            #add character
            pos+=1
            if kind==BYTE_STRING:
                ts.value.append(next)
            else:
                ts.value += chr(next)

            if next == 92: # '\'

                if byte_at(buf, pos) == 10:
                    ts.line_num += 1
                    if kind == BYTE_STRING:
                        ts.value.append(10)
                    else:
                        ts.value += chr(10)
                    pos+=1

                # special case where we have something in the form \c (c = " or ') in a raw string
                elif c == byte_at(buf, pos):
                    if kind == BYTE_STRING:
                        ts.value.append(c)
                    else:
                        ts.value += chr(c)
                    pos+=1

            elif next == 10: # newline ?
                k = KIND_ERROR
                break
    ts.end = pos

def get_string_normal(ts, pos, c, kind):
    buf = ts.buf
    if byte_at(buf, pos) == c and byte_at(buf, pos+1) == c:

        #TODO check end of buffer
        pos += 2
        while True:
            next = byte_at(buf, pos)

            if next == c and byte_at(buf, pos+1) == c and byte_at(buf, pos+2) == c:
                pos += 3
                break

            if next == 92: # '\'
                pos+=1
                if byte_at(buf, pos) == 10:
                    ts.line_num += 1
                    pos+=1
                elif kind == BYTE_STRING:
                    pos = byte_escape_character_function(buf, pos, ts)
                # kind == NORMAL_STRING
                else:
                    pos = string_escape_character_function(buf, pos, ts)

            else:
                pos+=1
                if next == 10:
                    ts.line_num += 1

                if kind==BYTE_STRING:
                    ts.value.append(next)
                else:
                    ts.value += chr(next)

    else:
        while True:
            next = byte_at(buf, pos)
            if next == c:
                pos += 1
                break
            elif next == 92: # '\'
                pos+=1

                if byte_at(buf, pos) == 10:
                    pos+=1
                    ts.line_num += 1

                elif kind == BYTE_STRING:
                    pos = byte_escape_character_function(buf, pos, ts)
                # kind == NORMAL_STRING
                else:
                    pos = string_escape_character_function(buf, pos, ts)

            elif next == 10: # newline ?
                k = KIND_ERROR
                break
            else:
                if kind==BYTE_STRING:
                    ts.value.append(next)
                else:
                    ts.value += chr(next)
                pos += 1
    ts.end = pos

def get_string(ts, pos, c, kind, raw):

    ts.token = STRING

    if kind == BYTE_STRING:
        ts.value=bytearray()
    else:
        # kind == UNICODE_STRING or other
        ts.value=""

    if raw:
        get_string_raw(ts, pos, c, kind)
    else:
        get_string_normal(ts, pos, c, kind)


    if kind==BYTE_STRING:
        ts.value = bytes(ts.value)

