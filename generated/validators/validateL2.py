from z3 import *

v1, v2, v3, v4, v5, v6, v7, v8, v9, v10 = Ints('v1 v2 v3 v4 v5 v6 v7 v8 v9 v10')
v1p, v2p, v3p, v4p, v5p, v6p, v7p, v8p, v9p, v10p = Ints('v1p v2p v3p v4p v5p v6p v7p v8p v9p v10p')

nd2, nd3, nd4, nd5, nd6 = Ints('nd2 nd3 nd4 nd5 nd6')

guard = (v8 == 0)

inv = And(v10 >= 0, v10 <= 101)

branch1 = And(
    v8 == 0,
    nd2 == 1,
    v10 < 100,
    nd3 < 0,

    v1p == v1,
    v2p == v2,
    v3p == nd3,
    v4p == v4,
    v5p == v5,
    v6p == v6,
    v7p == v7,
    v8p == If(nd3 < 0, 1, 0),
    v9p == nd2,
    v10p == v10 + 1
)

branch2 = And(
    v8 == 0,
    nd2 == 1,
    v10 < 100,
    Not(nd3 < 0),
    v10 + 1 < 100,
    nd4 == 0,

    v1p == v1,
    v2p == nd4,
    v3p == nd3,
    v4p == v4,
    v5p == v5,
    v6p == v6,
    v7p == v7,
    v8p == 1,
    v9p == nd2,
    v10p == v10 + 2
)

branch3 = And(
    v8 == 0,
    nd2 == 1,
    v10 < 100,
    Not(nd3 < 0),
    v10 + 1 < 100,
    nd4 != 0,

    v1p == v1,
    v2p == nd4,
    v3p == nd3,
    v4p == v4,
    v5p == v5,
    v6p == v6,
    v7p == v7,
    v8p == If(nd4 == 0, 1, 0),
    v9p == nd2,
    v10p == v10 + 2
)

branch4 = And(
    v8 == 0,
    nd2 == 1,
    v10 < 100,
    Not(nd3 < 0),
    Not(v10 + 1 < 100),

    v1p == v1,
    v2p == -1,
    v3p == nd3,
    v4p == v4,
    v5p == v5,
    v6p == v6,
    v7p == v7,
    v8p == 0,
    v9p == nd2,
    v10p == v10 + 2
)

branch5 = And(
    v8 == 0,
    nd2 == 1,
    Not(v10 < 100),

    v1p == v1,
    v2p == v2,
    v3p == -1,
    v4p == v4,
    v5p == v5,
    v6p == v6,
    v7p == v7,
    v8p == 1,
    v9p == nd2,
    v10p == v10 + 1
)

branch6 = And(
    v8 == 0,
    nd2 == 2,
    v10 < 100,

    v1p == nd5,
    v2p == v2,
    v3p == v3,
    v4p == v4,
    v5p == v5,
    v6p == v6,
    v7p == v7,
    v8p == nd5,
    v9p == nd2,
    v10p == v10 + 1
)

branch7 = And(
    Or(
        And(v8 == 0, nd2 == 2, Not(v10 < 100)),
        And(v8 == 0, nd2 != 1, nd2 != 2, Not(v10 < 100))
    ),

    v1p == -1,
    v2p == v2,
    v3p == v3,
    v4p == v4,
    v5p == v5,
    v6p == v6,
    v7p == v7,
    v8p == -1,
    v9p == nd2,
    v10p == v10 + 1
)

branch8 = And(
    v8 == 0,
    nd2 != 1,
    nd2 != 2,
    v10 < 100,

    v1p == nd6,
    v2p == v2,
    v3p == v3,
    v4p == v4,
    v5p == v5,
    v6p == v6,
    v7p == v7,
    v8p == nd6,
    v9p == nd2,
    v10p == v10 + 1
)

transition = Or(branch1, branch2, branch3, branch4, branch5, branch6, branch7, branch8)

rf = If(v8 == 0,
        If(v10 < 100, 101 - v10, 1),
        0)
rfp = If(v8p == 0,
         If(v10p < 100, 101 - v10p, 1),
         0)

def check_unsat(name, formula):
    s = Solver()
    s.add(formula)
    r = s.check()
    print(f"{name}: {r}")
    if r == sat:
        print("counterexample:")
        print(s.model())
    return r

r1 = check_unsat(
    "nonnegativity violated",
    And(inv, guard, rf < 0)
)

r2 = check_unsat(
    "decrease violated",
    And(inv, guard, transition, Not(rfp < rf))
)

if r1 == unsat and r2 == unsat:
    print("Ranking function candidate is valid.")
    print("Loop is terminating.")
else:
    print("Ranking function candidate is not valid.")