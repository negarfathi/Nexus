from z3 import *

v1, v2, v3, v4, v5, v6, v7, v8, v9, v10 = Ints('v1 v2 v3 v4 v5 v6 v7 v8 v9 v10')
v1p, v2p, v3p, v4p, v5p, v6p, v7p, v8p, v9p, v10p = Ints('v1p v2p v3p v4p v5p v6p v7p v8p v9p v10p')

w1, w2, w3, w4, w5, w6, w7, w8, w9, w10 = Ints('w1 w2 w3 w4 w5 w6 w7 w8 w9 w10')
w1p, w2p, w3p, w4p, w5p, w6p, w7p, w8p, w9p, w10p = Ints('w1p w2p w3p w4p w5p w6p w7p w8p w9p w10p')

nd2, nd3, nd4, nd5, nd6 = Ints('nd2 nd3 nd4 nd5 nd6')

V = [v1, v2, v3, v4, v5, v6, v7, v8, v9, v10]
Vp = [v1p, v2p, v3p, v4p, v5p, v6p, v7p, v8p, v9p, v10p]

W = [w1, w2, w3, w4, w5, w6, w7, w8, w9, w10]
Wp = [w1p, w2p, w3p, w4p, w5p, w6p, w7p, w8p, w9p, w10p]

guard = (v7 != 1)

def mk_rel(name, n_ints):
    return Function(name, *([IntSort()] * n_ints), BoolSort())

def rel_call(R, xs, ys):
    return R(*(xs + ys))

STEP_L2      = mk_rel("STEP_L2", 20)
E2E_L2       = mk_rel("E2E_L2", 20)

STEP_L1      = mk_rel("STEP_L1", 20)
REACH_L1     = Function("REACH_L1", *([IntSort()] * 10), BoolSort())

BAD_NONNEG   = Function("BAD_NONNEG", *([IntSort()] * 10), BoolSort())
BAD_DECREASE = Function("BAD_DECREASE", *([IntSort()] * 20), BoolSort())

fp = Fixedpoint()
fp.set(engine="spacer")
fp.register_relation(
    STEP_L2, E2E_L2, STEP_L1, REACH_L1,
    BAD_NONNEG, BAD_DECREASE
)

fp.declare_var(
    v1, v2, v3, v4, v5, v6, v7, v8, v9, v10,
    v1p, v2p, v3p, v4p, v5p, v6p, v7p, v8p, v9p, v10p,
    w1, w2, w3, w4, w5, w6, w7, w8, w9, w10,
    w1p, w2p, w3p, w4p, w5p, w6p, w7p, w8p, w9p, w10p,
    nd2, nd3, nd4, nd5, nd6
)

# STEP_L2
fp.rule(
    rel_call(STEP_L2, V, W),
    [
        v8 == 0, nd2 == 1, v10 < 100, nd3 < 0,
        w1 == v1, w2 == v2, w3 == nd3, w4 == v4, w5 == v5, w6 == v6, w7 == v7, w8 == If(nd3 < 0, 1, 0), w9 == nd2, w10 == v10 + 1
    ],
    name="L2_B1"
)

fp.rule(
    rel_call(STEP_L2, V, W),
    [
        v8 == 0, nd2 == 1, v10 < 100, Not(nd3 < 0), v10 + 1 < 100, nd4 == 0,
        w1 == v1, w2 == nd4, w3 == nd3, w4 == v4, w5 == v5, w6 == v6, w7 == v7, w8 == 1, w9 == nd2, w10 == v10 + 2
    ],
    name="L2_B2"
)

fp.rule(
    rel_call(STEP_L2, V, W),
    [
        v8 == 0, nd2 == 1, v10 < 100, Not(nd3 < 0), v10 + 1 < 100, nd4 != 0,
        w1 == v1, w2 == nd4, w3 == nd3, w4 == v4, w5 == v5, w6 == v6, w7 == v7, w8 == If(nd4 == 0, 1, 0), w9 == nd2, w10 == v10 + 2
    ],
    name="L2_B3"
)

fp.rule(
    rel_call(STEP_L2, V, W),
    [
        v8 == 0, nd2 == 1, v10 < 100, Not(nd3 < 0), Not(v10 + 1 < 100),
        w1 == v1, w2 == -1, w3 == nd3, w4 == v4, w5 == v5, w6 == v6, w7 == v7, w8 == 0, w9 == nd2, w10 == v10 + 2
    ],
    name="L2_B4"
)

fp.rule(
    rel_call(STEP_L2, V, W),
    [
        v8 == 0, nd2 == 1, Not(v10 < 100),
        w1 == v1, w2 == v2, w3 == -1, w4 == v4, w5 == v5, w6 == v6, w7 == v7, w8 == 1, w9 == nd2, w10 == v10 + 1
    ],
    name="L2_B5"
)

fp.rule(
    rel_call(STEP_L2, V, W),
    [
        v8 == 0, nd2 == 2, v10 < 100,
        w1 == nd5, w2 == v2, w3 == v3, w4 == v4, w5 == v5, w6 == v6, w7 == v7, w8 == nd5, w9 == nd2, w10 == v10 + 1
    ],
    name="L2_B6"
)

fp.rule(
    rel_call(STEP_L2, V, W),
    [
        Or(
            And(v8 == 0, nd2 == 2, Not(v10 < 100)),
            And(v8 == 0, nd2 != 1, nd2 != 2, Not(v10 < 100))
        ),
        w1 == -1, w2 == v2, w3 == v3, w4 == v4, w5 == v5, w6 == v6, w7 == v7, w8 == -1, w9 == nd2, w10 == v10 + 1
    ],
    name="L2_B7"
)

fp.rule(
    rel_call(STEP_L2, V, W),
    [
        v8 == 0, nd2 != 1, nd2 != 2, v10 < 100,
        w1 == nd6, w2 == v2, w3 == v3, w4 == v4, w5 == v5, w6 == v6, w7 == v7, w8 == nd6, w9 == nd2, w10 == v10 + 1
    ],
    name="L2_B8"
)

# E2E_L2
fp.rule(
    rel_call(E2E_L2, V, Vp),
    [
        v8 != 0,
        v1p == v1, v2p == v2, v3p == v3, v4p == v4, v5p == v5, v6p == v6, v7p == v7, v8p == v8, v9p == v9, v10p == v10
    ],
    name="E2E_L2_base"
)

fp.rule(
    rel_call(E2E_L2, V, Vp),
    [
        rel_call(STEP_L2, V, W),
        rel_call(E2E_L2, W, Vp)
    ],
    name="E2E_L2_step"
)

# STEP_L1
fp.rule(
    rel_call(STEP_L1, V, Vp),
    [
        guard,
        rel_call(E2E_L2, [v1, v2, v3, 1, v7, v6, v7, 0, v9, v10], Wp),
        w8p == -1,
        v1p == w1p, v2p == w2p, v3p == w3p, v4p == 1, v5p == v7, v6p == v6, v7p == 1, v8p == w8p, v9p == w9p, v10p == w10p
    ],
    name="L1_B1"
)

fp.rule(
    rel_call(STEP_L1, V, Vp),
    [
        guard,
        rel_call(E2E_L2, [v1, v2, v3, 1, v7, v6, v7, 0, v9, v10], Wp),
        w8p != -1,
        v1p == w1p, v2p == w2p, v3p == w3p, v4p == 1, v5p == v7, v6p == v6, v7p == v7, v8p == w8p, v9p == w9p, v10p == w10p
    ],
    name="L1_B2"
)

# REACH_L1
fp.rule(
    REACH_L1(*V),
    [
        v6 == 0,
        v8 == 0,
        v10 == 0
    ],
    name="REACH_L1_init"
)

fp.rule(
    REACH_L1(*Vp),
    [
        REACH_L1(*V),
        rel_call(STEP_L1, V, Vp)
    ],
    name="REACH_L1_step"
)

rs = And(v7 != 1, v10 >= 0)
rsp = And(v7p != 1, v10p >= 0)

init_witness = And(
    v6 == 0,
    v7 == 0,
    v8 == 0,
    v10 == 0
)

WITNESS_L1_STEP = And(
    guard,

    Or(
        And(v10 < 100, nd2 == 1, nd3 == -1),
        And(Not(v10 < 100), nd2 == 1)
    ),

    v1p == v1,
    v2p == v2,
    v3p == -1,
    v4p == 1,
    v5p == v7,
    v6p == v6,
    v7p == v7,
    v8p == 1,
    v9p == 1,
    v10p == v10 + 1
)

def check_sat(name, formula):
    s = Solver()
    s.add(formula)
    r = s.check()
    print(f"{name}: {r}")
    if r == sat:
        print("model:")
        print(s.model())
    return r

def check_unsat(name, formula):
    s = Solver()
    s.add(formula)
    r = s.check()
    print(f"{name}: {r}")
    if r == sat:
        print("counterexample:")
        print(s.model())
    return r

r0 = check_sat(
    "1. init intersects recurrent set",
    And(init_witness, rs)
)

r1 = check_unsat(
    "2. recurrent set not inside guard",
    And(rs, Not(guard))
)

r2 = check_unsat(
    "3. witness leaves recurrent set",
    And(rs, WITNESS_L1_STEP, Not(rsp))
)

r3 = check_unsat(
    "4. witness is not enabled",
    And(
        rs,
        Not(
            Exists(
                [v1p, v2p, v3p, v4p, v5p, v6p, v7p, v8p, v9p, v10p,
                 nd2, nd3, nd4, nd5, nd6],
                WITNESS_L1_STEP
            )
        )
    )
)

if r0 == sat and r1 == unsat and r2 == unsat and r3 == unsat:
    print("Recurrent set is valid.")
    print("Loop is non-terminating.")
else:
    print("Recurrent set is not valid.")