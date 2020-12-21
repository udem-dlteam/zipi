#!/usr/bin/env python

iters_scale = 100000  # scaling of iterations over benchmark body
dups_scale = 10       # scaling of duplications of benchmarked code in body

# These scaling factors give a CPython execution time of about 0.1
# seconds for most benchmarks.  So multiplying one or the other by 10
# should give an execution time close to 1 second.

benchmarks = [
#iters/dups  head             body             tail   filename
[13,8, '','',                'x=0;x=1',       '',    'var_int_assign_0_1'],
[13,3, 'x=1','',             'x=x+1',         '',    'var_int_add_1'],
[13,3, 'x=1','',             'x+=1',          '',    'var_int_inc'],
[13,3, 'x=1;y=1','',         'x=x+y',         '',    'var_int_add_var'],
[13,3, 'x=1','',             'x=x-1',         '',    'var_int_sub_1'],
[13,3, 'x=1','',             'x-=1',          '',    'var_int_dec'],
[13,3, 'x=1;y=1','',         'x=x-y',         '',    'var_int_sub_var'],
[13,3, '','x=1',             'x=x*2',         '',    'var_int_mul_2'],
[13,3, 'y=2','x=1',          'x=x*y',         '',    'var_int_mul_var'],
[13,3, 'x=1;y=2','',         'z=(x<y)',       '',    'var_int_lt_var'],
[16,3, 'x=1;y=2','',         'if x<y:x=0',    '',    'if_var_int_lt_var'],
[50,3, 'false=False','',     'if false:x=0',  '',    'if_false'],
[30,3, 'true=True','',       'if true:x=0',   '',    'if_true'],
[13,3, 'm=__builtins__','',  'x=m.__name__',  '',    'attr_read'],
[ 9,3, 's="a"','',           'x=s.__add__',   '',    'method_bind'],
[20,4, 'global g;x=0','g=0', 'x=g',           '',    'global_read'],
[20,4, 'global g;x=0','g=0', 'g=x',           '',    'global_write1'],
[20,2, 'global g;x=0','g1=0;g2=0','g1=x;g2=x','',    'global_write2'],
[20,1, 'global g;x=0','g1=0;g2=0;g3=0;g4=0','g1=x;g2=x;g3=x;g4=x','','global_write4'],
[ 7,4, 'global g','g=0',     'g+=1',          '',    'global_inc'],
[16,3, 'lst=[0]','',         'x=lst[0]',      '',    'var_list_index_0'],
[16,3, 'lst=[0];y=0','',     'x=lst[y]',      '',    'var_list_index_var'],
[16,3, 'tup=(0,)','',        'x=tup[0]',      '',    'var_tuple_index_0'],
[16,3, 'tup=(0,);y=0','',    'x=tup[y]',      '',    'var_tuple_index_var'],
[ 7,3, 's1="a";s2="b"','',   'x=s1+s2',       '',    'var_str_add_var'],
[ 1,0, 's1="a"','s2="b";x=100','while x>0:x-=1;s2+=s1','','accum_str_100'],
[13,3, 's="x"','',           'ord(s)',        '',    'call_ord_str'],
[ 1,0, '','',                'for x in range(100):pass', '', 'for_range_100'],
[ 1,0, '','x=250',            'while x>0:x-=1', '', 'while_100'],
]

template = """\
# Auto-generated

import time

bench_iterations = {iterations}
bench_duplications = {duplications}

def bench_exec():
{head}
    bench_counter = bench_iterations
    while bench_counter > 0:
        bench_counter -= 1
{iter_head}
{body}
{tail}

bench_time = time.time()
bench_exec()
bench_time = time.time() - bench_time
print(str(bench_time) + ' seconds for ' + str(bench_iterations*bench_duplications) + ' executions of: ' + {code})


"""

head_indent = 4
body_indent = 8
tail_indent = 4

def add_indent(code, indent):
    return '\n'.join(map(lambda s: ' '*indent + s, code.split('\n')))

def expand_template(iterations, duplications, head, iter_head, body, tail, code):
    return template.format(iterations=iterations,
                           duplications=duplications,
                           head=add_indent(head, head_indent),
                           iter_head=add_indent(iter_head, body_indent),
                           body=add_indent(body, body_indent),
                           tail=add_indent(tail, tail_indent),
                           code=repr(code))

def expand_benchmark(specs):
    iters = specs[0] * iters_scale
    dups = specs[1] * dups_scale
    if dups == 0: dups = 1
    return expand_template(iters,
                           dups,
                           specs[2],
                           specs[3],
                           '\n'.join([specs[4]] * dups),
                           specs[5],
                           specs[4])

def gen_benchmark(specs):
    filename = 'micro_' + specs[6] + '.py'
    code = '# ' + filename + '\n' + expand_benchmark(specs)
    #print(code);return
    with open(filename, 'w') as f:
        f.write(code)

def gen_all():
    for b in benchmarks:
        gen_benchmark(b)

gen_all()
