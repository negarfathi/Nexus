#!/usr/bin/env python3

from z3 import *

fp = Fixedpoint()
fp.set(engine="spacer")

# ============================================================
# Variables
# ============================================================

# l1
# State symbols
l1_v1 = Int("l1_v1")
fp.declare_var(l1_v1)
l1_v1_next = Int("l1_v1_next")
fp.declare_var(l1_v1_next)
l1_v1_out = Int("l1_v1_out")
fp.declare_var(l1_v1_out)
l1_v2 = Int("l1_v2")
fp.declare_var(l1_v2)
l1_v2_next = Int("l1_v2_next")
fp.declare_var(l1_v2_next)
l1_v2_out = Int("l1_v2_out")
fp.declare_var(l1_v2_out)
l1_v3 = Int("l1_v3")
fp.declare_var(l1_v3)
l1_v3_next = Int("l1_v3_next")
fp.declare_var(l1_v3_next)
l1_v3_out = Int("l1_v3_out")
fp.declare_var(l1_v3_out)
l1_v4 = Int("l1_v4")
fp.declare_var(l1_v4)
l1_v4_next = Int("l1_v4_next")
fp.declare_var(l1_v4_next)
l1_v4_out = Int("l1_v4_out")
fp.declare_var(l1_v4_out)
l1_v5 = Int("l1_v5")
fp.declare_var(l1_v5)
l1_v5_next = Int("l1_v5_next")
fp.declare_var(l1_v5_next)
l1_v5_out = Int("l1_v5_out")
fp.declare_var(l1_v5_out)
l1_v6 = Int("l1_v6")
fp.declare_var(l1_v6)
l1_v6_next = Int("l1_v6_next")
fp.declare_var(l1_v6_next)
l1_v6_out = Int("l1_v6_out")
fp.declare_var(l1_v6_out)
l1_v7 = Int("l1_v7")
fp.declare_var(l1_v7)
l1_v7_next = Int("l1_v7_next")
fp.declare_var(l1_v7_next)
l1_v7_out = Int("l1_v7_out")
fp.declare_var(l1_v7_out)
l1_state = [l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7]
l1_next_state = [l1_v1_next, l1_v2_next, l1_v3_next, l1_v4_next, l1_v5_next, l1_v6_next, l1_v7_next]
l1_output_state = [l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out, l1_v5_out, l1_v6_out, l1_v7_out]

# Nondeterministic symbols
l1_nd1 = Int("l1_nd1")
fp.declare_var(l1_nd1)
l1_nd2 = Int("l1_nd2")
fp.declare_var(l1_nd2)
l1_nd3 = Int("l1_nd3")
fp.declare_var(l1_nd3)
l1_nd4 = Int("l1_nd4")
fp.declare_var(l1_nd4)

# l2
# State symbols
l2_v1 = Int("l2_v1")
fp.declare_var(l2_v1)
l2_v1_next = Int("l2_v1_next")
fp.declare_var(l2_v1_next)
l2_v1_out = Int("l2_v1_out")
fp.declare_var(l2_v1_out)
l2_v2 = Int("l2_v2")
fp.declare_var(l2_v2)
l2_v2_next = Int("l2_v2_next")
fp.declare_var(l2_v2_next)
l2_v2_out = Int("l2_v2_out")
fp.declare_var(l2_v2_out)
l2_v3 = Int("l2_v3")
fp.declare_var(l2_v3)
l2_v3_next = Int("l2_v3_next")
fp.declare_var(l2_v3_next)
l2_v3_out = Int("l2_v3_out")
fp.declare_var(l2_v3_out)
l2_v4 = Int("l2_v4")
fp.declare_var(l2_v4)
l2_v4_next = Int("l2_v4_next")
fp.declare_var(l2_v4_next)
l2_v4_out = Int("l2_v4_out")
fp.declare_var(l2_v4_out)
l2_v5 = Int("l2_v5")
fp.declare_var(l2_v5)
l2_v5_next = Int("l2_v5_next")
fp.declare_var(l2_v5_next)
l2_v5_out = Int("l2_v5_out")
fp.declare_var(l2_v5_out)
l2_v6 = Int("l2_v6")
fp.declare_var(l2_v6)
l2_v6_next = Int("l2_v6_next")
fp.declare_var(l2_v6_next)
l2_v6_out = Int("l2_v6_out")
fp.declare_var(l2_v6_out)
l2_v7 = Int("l2_v7")
fp.declare_var(l2_v7)
l2_v7_next = Int("l2_v7_next")
fp.declare_var(l2_v7_next)
l2_v7_out = Int("l2_v7_out")
fp.declare_var(l2_v7_out)
l2_state = [l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7]
l2_next_state = [l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next, l2_v5_next, l2_v6_next, l2_v7_next]
l2_output_state = [l2_v1_out, l2_v2_out, l2_v3_out, l2_v4_out, l2_v5_out, l2_v6_out, l2_v7_out]

# l3
# State symbols
l3_v1 = Int("l3_v1")
fp.declare_var(l3_v1)
l3_v1_next = Int("l3_v1_next")
fp.declare_var(l3_v1_next)
l3_v1_out = Int("l3_v1_out")
fp.declare_var(l3_v1_out)
l3_v2 = Int("l3_v2")
fp.declare_var(l3_v2)
l3_v2_next = Int("l3_v2_next")
fp.declare_var(l3_v2_next)
l3_v2_out = Int("l3_v2_out")
fp.declare_var(l3_v2_out)
l3_v3 = Int("l3_v3")
fp.declare_var(l3_v3)
l3_v3_next = Int("l3_v3_next")
fp.declare_var(l3_v3_next)
l3_v3_out = Int("l3_v3_out")
fp.declare_var(l3_v3_out)
l3_v4 = Int("l3_v4")
fp.declare_var(l3_v4)
l3_v4_next = Int("l3_v4_next")
fp.declare_var(l3_v4_next)
l3_v4_out = Int("l3_v4_out")
fp.declare_var(l3_v4_out)
l3_v5 = Int("l3_v5")
fp.declare_var(l3_v5)
l3_v5_next = Int("l3_v5_next")
fp.declare_var(l3_v5_next)
l3_v5_out = Int("l3_v5_out")
fp.declare_var(l3_v5_out)
l3_v6 = Int("l3_v6")
fp.declare_var(l3_v6)
l3_v6_next = Int("l3_v6_next")
fp.declare_var(l3_v6_next)
l3_v6_out = Int("l3_v6_out")
fp.declare_var(l3_v6_out)
l3_v7 = Int("l3_v7")
fp.declare_var(l3_v7)
l3_v7_next = Int("l3_v7_next")
fp.declare_var(l3_v7_next)
l3_v7_out = Int("l3_v7_out")
fp.declare_var(l3_v7_out)
l3_state = [l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7]
l3_next_state = [l3_v1_next, l3_v2_next, l3_v3_next, l3_v4_next, l3_v5_next, l3_v6_next, l3_v7_next]
l3_output_state = [l3_v1_out, l3_v2_out, l3_v3_out, l3_v4_out, l3_v5_out, l3_v6_out, l3_v7_out]

# ============================================================
# Relation declarations
# ============================================================

# l1
l1_entry_states = Function("l1_entry_states", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_entry_states)
l1_iteration_steps = Function("l1_iteration_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_iteration_steps)
l1_exit_steps = Function("l1_exit_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_exit_steps)
l1_return_steps = Function("l1_return_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_return_steps)
l1_reachable_header_states = Function("l1_reachable_header_states", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_reachable_header_states)
l1_header_to_exit = Function("l1_header_to_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_header_to_exit)
l1_header_to_return = Function("l1_header_to_return", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_header_to_return)
l1_actual_exit = Function("l1_actual_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_actual_exit)

# l2
l2_entry_states = Function("l2_entry_states", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l2_entry_states)
l2_iteration_steps = Function("l2_iteration_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l2_iteration_steps)
l2_exit_steps = Function("l2_exit_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l2_exit_steps)
l2_return_steps = Function("l2_return_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l2_return_steps)
l2_reachable_header_states = Function("l2_reachable_header_states", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l2_reachable_header_states)
l2_header_to_exit = Function("l2_header_to_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l2_header_to_exit)
l2_header_to_return = Function("l2_header_to_return", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l2_header_to_return)
l2_actual_exit = Function("l2_actual_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l2_actual_exit)

# l3
l3_entry_states = Function("l3_entry_states", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l3_entry_states)
l3_iteration_steps = Function("l3_iteration_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l3_iteration_steps)
l3_exit_steps = Function("l3_exit_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l3_exit_steps)
l3_return_steps = Function("l3_return_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l3_return_steps)
l3_reachable_header_states = Function("l3_reachable_header_states", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l3_reachable_header_states)
l3_header_to_exit = Function("l3_header_to_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l3_header_to_exit)
l3_header_to_return = Function("l3_header_to_return", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l3_header_to_return)
l3_actual_exit = Function("l3_actual_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l3_actual_exit)

# ============================================================
# Dependency loop: l1
# ============================================================

# Guard
l1_guard = (l1_v2 > IntVal(0))

# Entry states
l1_entry_states_p1 = And((l1_nd1 < IntVal(0)), (l1_v1 == IntVal(0)), (l1_v2 == IntVal(6)), (l1_v3 == l1_nd2), (l1_v4 == l1_nd3), (l1_v5 == l1_nd4), (l1_v6 == l1_v6), (l1_v7 == l1_v7))
fp.rule(l1_entry_states(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7), l1_entry_states_p1, name="l1_entry_states_p1")

l1_entry_states_p2 = And(And((l1_nd1 >= IntVal(0)), (l1_nd1 > IntVal(10))), (l1_v1 == IntVal(0)), (l1_v2 == IntVal(10)), (l1_v3 == l1_nd2), (l1_v4 == l1_nd3), (l1_v5 == l1_nd4), (l1_v6 == l1_v6), (l1_v7 == l1_v7))
fp.rule(l1_entry_states(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7), l1_entry_states_p2, name="l1_entry_states_p2")

l1_entry_states_p3 = And(And((l1_nd1 >= IntVal(0)), (l1_nd1 <= IntVal(10))), (l1_v1 == IntVal(0)), (l1_v2 == l1_nd1), (l1_v3 == l1_nd2), (l1_v4 == l1_nd3), (l1_v5 == l1_nd4), (l1_v6 == l1_v6), (l1_v7 == l1_v7))
fp.rule(l1_entry_states(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7), l1_entry_states_p3, name="l1_entry_states_p3")

# Iteration steps
l1_iteration_steps_p1 = And(And((l1_v2 > IntVal(0)), (l1_v2 != IntVal(9)), (l1_v2 != IntVal(7)), ((l1_v2 - IntVal(1)) == IntVal(5))), (l1_v1_next == l1_v1), (l1_v2_next == (l1_v2 - IntVal(1))), (l1_v3_next == l1_v3), (l1_v4_next == l1_v4), (l1_v5_next == l1_v5), (l1_v6_next == l1_v6), (l1_v7_next == l1_v7))
fp.rule(l1_iteration_steps(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v1_next, l1_v2_next, l1_v3_next, l1_v4_next, l1_v5_next, l1_v6_next, l1_v7_next), l1_iteration_steps_p1, name="l1_iteration_steps_p1")

l1_iteration_steps_p2 = And(And((l1_v2 > IntVal(0)), (l1_v2 != IntVal(9)), (l1_v2 != IntVal(7)), ((l1_v2 - IntVal(1)) != IntVal(5))), (l1_v1_next == l1_v1), (l1_v2_next == ((l1_v2 - IntVal(1)) - IntVal(1))), (l1_v3_next == l1_v3), (l1_v4_next == l1_v4), (l1_v5_next == l1_v5), (l1_v6_next == l1_v6), (l1_v7_next == l1_v7))
fp.rule(l1_iteration_steps(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v1_next, l1_v2_next, l1_v3_next, l1_v4_next, l1_v5_next, l1_v6_next, l1_v7_next), l1_iteration_steps_p2, name="l1_iteration_steps_p2")

# Exit steps
l1_exit_steps_p1 = And(Or(And((l1_v2 > IntVal(0)), (l1_v2 != IntVal(9)), (l1_v2 == IntVal(7))), (l1_v2 <= IntVal(0))), (l1_v1_out == l1_v1), (l1_v2_out == l1_v2), (l1_v3_out == l1_v3), (l1_v4_out == l1_v4), (l1_v5_out == l1_v5), (l1_v6_out == l1_v6), (l1_v7_out == l1_v7))
fp.rule(l1_exit_steps(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out, l1_v5_out, l1_v6_out, l1_v7_out), l1_exit_steps_p1, name="l1_exit_steps_p1")

# Return steps
l1_return_steps_p1 = And((l1_v2 > IntVal(0)), (l1_v2 == IntVal(9)))
fp.rule(l1_return_steps(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7), l1_return_steps_p1, name="l1_return_steps_p1")

# Reachable header states
l1_reachable_header_states_base = l1_entry_states(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7)
fp.rule(l1_reachable_header_states(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7), l1_reachable_header_states_base, name="l1_reachable_header_states_base")

l1_reachable_header_states_recursive = And(l1_reachable_header_states(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7), l1_iteration_steps(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v1_next, l1_v2_next, l1_v3_next, l1_v4_next, l1_v5_next, l1_v6_next, l1_v7_next))
fp.rule(l1_reachable_header_states(l1_v1_next, l1_v2_next, l1_v3_next, l1_v4_next, l1_v5_next, l1_v6_next, l1_v7_next), l1_reachable_header_states_recursive, name="l1_reachable_header_states_recursive")

# Header to exit
l1_header_to_exit_base = l1_exit_steps(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out, l1_v5_out, l1_v6_out, l1_v7_out)
fp.rule(l1_header_to_exit(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out, l1_v5_out, l1_v6_out, l1_v7_out), l1_header_to_exit_base, name="l1_header_to_exit_base")

l1_header_to_exit_recursive = And(l1_iteration_steps(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v1_next, l1_v2_next, l1_v3_next, l1_v4_next, l1_v5_next, l1_v6_next, l1_v7_next), l1_header_to_exit(l1_v1_next, l1_v2_next, l1_v3_next, l1_v4_next, l1_v5_next, l1_v6_next, l1_v7_next, l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out, l1_v5_out, l1_v6_out, l1_v7_out))
fp.rule(l1_header_to_exit(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out, l1_v5_out, l1_v6_out, l1_v7_out), l1_header_to_exit_recursive, name="l1_header_to_exit_recursive")

# Header to return
l1_header_to_return_base = l1_return_steps(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7)
fp.rule(l1_header_to_return(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7), l1_header_to_return_base, name="l1_header_to_return_base")

l1_header_to_return_recursive = And(l1_iteration_steps(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v1_next, l1_v2_next, l1_v3_next, l1_v4_next, l1_v5_next, l1_v6_next, l1_v7_next), l1_header_to_return(l1_v1_next, l1_v2_next, l1_v3_next, l1_v4_next, l1_v5_next, l1_v6_next, l1_v7_next))
fp.rule(l1_header_to_return(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7), l1_header_to_return_recursive, name="l1_header_to_return_recursive")

# Actual exit
l1_actual_exit_rule = And(l1_entry_states(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7), l1_header_to_exit(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out, l1_v5_out, l1_v6_out, l1_v7_out))
fp.rule(l1_actual_exit(l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out, l1_v5_out, l1_v6_out, l1_v7_out), l1_actual_exit_rule, name="l1_actual_exit_rule")

# ============================================================
# Dependency loop: l2
# ============================================================

# Guard
l2_guard = (l2_v6 >= IntVal(0))

# Entry states
l2_entry_states_p1 = And((l1_v3_out < IntVal(0)), l1_actual_exit(l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out, l1_v5_out, l1_v6_out, l1_v7_out), (l2_v1 == l1_v1_out), (l2_v2 == l1_v2_out), (l2_v3 == IntVal(0)), (l2_v4 == l1_v4_out), (l2_v5 == l1_v5_out), (l2_v6 == IntVal(0)), (l2_v7 == IntVal(0)))
fp.rule(l2_entry_states(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7), l2_entry_states_p1, name="l2_entry_states_p1")

l2_entry_states_p2 = And(And((l1_v3_out >= IntVal(0)), (l1_v3_out > IntVal(10))), l1_actual_exit(l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out, l1_v5_out, l1_v6_out, l1_v7_out), (l2_v1 == l1_v1_out), (l2_v2 == l1_v2_out), (l2_v3 == IntVal(10)), (l2_v4 == l1_v4_out), (l2_v5 == l1_v5_out), (l2_v6 == IntVal(10)), (l2_v7 == IntVal(0)))
fp.rule(l2_entry_states(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7), l2_entry_states_p2, name="l2_entry_states_p2")

l2_entry_states_p3 = And(And((l1_v3_out >= IntVal(0)), (l1_v3_out <= IntVal(10))), l1_actual_exit(l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out, l1_v5_out, l1_v6_out, l1_v7_out), (l2_v1 == l1_v1_out), (l2_v2 == l1_v2_out), (l2_v3 == l1_v3_out), (l2_v4 == l1_v4_out), (l2_v5 == l1_v5_out), (l2_v6 == l1_v3_out), (l2_v7 == IntVal(0)))
fp.rule(l2_entry_states(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7), l2_entry_states_p3, name="l2_entry_states_p3")

# Iteration steps
l2_iteration_steps_p1 = And(And((l2_v6 >= IntVal(0)), (l2_v6 == IntVal(10))), (l2_v1_next == l2_v1), (l2_v2_next == l2_v2), (l2_v3_next == l2_v3), (l2_v4_next == l2_v4), (l2_v5_next == l2_v5), (l2_v6_next == IntVal(4)), (l2_v7_next == l2_v7))
fp.rule(l2_iteration_steps(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next, l2_v5_next, l2_v6_next, l2_v7_next), l2_iteration_steps_p1, name="l2_iteration_steps_p1")

l2_iteration_steps_p2 = And(And((l2_v6 >= IntVal(0)), (l2_v6 != IntVal(10)), (l2_v6 != IntVal(8)), (l2_v6 != IntVal(6)), (l2_v4 == IntVal(0)), (l2_v6 == IntVal(2))), l3_header_to_exit(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, (l2_v6 + IntVal(2)), l3_v1_out, l3_v2_out, l3_v3_out, l3_v4_out, l3_v5_out, l3_v6_out, l3_v7_out), (l2_v1_next == l2_v1), (l2_v2_next == l2_v2), (l2_v3_next == l2_v3), (l2_v4_next == l2_v4), (l2_v5_next == l2_v5), (l2_v6_next == l2_v6), (l2_v7_next == l3_v7_out))
fp.rule(l2_iteration_steps(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next, l2_v5_next, l2_v6_next, l2_v7_next), l2_iteration_steps_p2, name="l2_iteration_steps_p2")

l2_iteration_steps_p3 = And(Or(And((l2_v6 >= IntVal(0)), (l2_v6 != IntVal(10)), (l2_v6 != IntVal(8)), (l2_v6 != IntVal(6)), (l2_v4 == IntVal(0)), (l2_v6 != IntVal(2))), And((l2_v6 >= IntVal(0)), (l2_v6 != IntVal(10)), (l2_v6 != IntVal(8)), (l2_v6 != IntVal(6)), (l2_v4 != IntVal(0)))), l3_header_to_exit(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, (l2_v6 + IntVal(2)), l3_v1_out, l3_v2_out, l3_v3_out, l3_v4_out, l3_v5_out, l3_v6_out, l3_v7_out), (l2_v1_next == l2_v1), (l2_v2_next == l2_v2), (l2_v3_next == l2_v3), (l2_v4_next == l2_v4), (l2_v5_next == l2_v5), (l2_v6_next == (l2_v6 - IntVal(1))), (l2_v7_next == l3_v7_out))
fp.rule(l2_iteration_steps(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next, l2_v5_next, l2_v6_next, l2_v7_next), l2_iteration_steps_p3, name="l2_iteration_steps_p3")

# Exit steps
l2_exit_steps_p1 = And(Or(And((l2_v6 >= IntVal(0)), (l2_v6 != IntVal(10)), (l2_v6 != IntVal(8)), (l2_v6 == IntVal(6))), (l2_v6 < IntVal(0))), (l2_v1_out == l2_v1), (l2_v2_out == l2_v2), (l2_v3_out == l2_v3), (l2_v4_out == l2_v4), (l2_v5_out == l2_v5), (l2_v6_out == l2_v6), (l2_v7_out == l2_v7))
fp.rule(l2_exit_steps(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v1_out, l2_v2_out, l2_v3_out, l2_v4_out, l2_v5_out, l2_v6_out, l2_v7_out), l2_exit_steps_p1, name="l2_exit_steps_p1")

# Return steps
l2_return_steps_p1 = And((l2_v6 >= IntVal(0)), (l2_v6 != IntVal(10)), (l2_v6 == IntVal(8)))
fp.rule(l2_return_steps(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7), l2_return_steps_p1, name="l2_return_steps_p1")

l2_return_steps_p2 = And(And((l2_v6 >= IntVal(0)), (l2_v6 != IntVal(10)), (l2_v6 != IntVal(8)), (l2_v6 != IntVal(6))), l3_header_to_return(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, (l2_v6 + IntVal(2))))
fp.rule(l2_return_steps(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7), l2_return_steps_p2, name="l2_return_steps_p2")

# Reachable header states
l2_reachable_header_states_base = l2_entry_states(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7)
fp.rule(l2_reachable_header_states(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7), l2_reachable_header_states_base, name="l2_reachable_header_states_base")

l2_reachable_header_states_recursive = And(l2_reachable_header_states(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7), l2_iteration_steps(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next, l2_v5_next, l2_v6_next, l2_v7_next))
fp.rule(l2_reachable_header_states(l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next, l2_v5_next, l2_v6_next, l2_v7_next), l2_reachable_header_states_recursive, name="l2_reachable_header_states_recursive")

# Header to exit
l2_header_to_exit_base = l2_exit_steps(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v1_out, l2_v2_out, l2_v3_out, l2_v4_out, l2_v5_out, l2_v6_out, l2_v7_out)
fp.rule(l2_header_to_exit(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v1_out, l2_v2_out, l2_v3_out, l2_v4_out, l2_v5_out, l2_v6_out, l2_v7_out), l2_header_to_exit_base, name="l2_header_to_exit_base")

l2_header_to_exit_recursive = And(l2_iteration_steps(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next, l2_v5_next, l2_v6_next, l2_v7_next), l2_header_to_exit(l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next, l2_v5_next, l2_v6_next, l2_v7_next, l2_v1_out, l2_v2_out, l2_v3_out, l2_v4_out, l2_v5_out, l2_v6_out, l2_v7_out))
fp.rule(l2_header_to_exit(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v1_out, l2_v2_out, l2_v3_out, l2_v4_out, l2_v5_out, l2_v6_out, l2_v7_out), l2_header_to_exit_recursive, name="l2_header_to_exit_recursive")

# Header to return
l2_header_to_return_base = l2_return_steps(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7)
fp.rule(l2_header_to_return(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7), l2_header_to_return_base, name="l2_header_to_return_base")

l2_header_to_return_recursive = And(l2_iteration_steps(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next, l2_v5_next, l2_v6_next, l2_v7_next), l2_header_to_return(l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next, l2_v5_next, l2_v6_next, l2_v7_next))
fp.rule(l2_header_to_return(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7), l2_header_to_return_recursive, name="l2_header_to_return_recursive")

# Actual exit
l2_actual_exit_rule = And(l2_entry_states(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7), l2_header_to_exit(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v1_out, l2_v2_out, l2_v3_out, l2_v4_out, l2_v5_out, l2_v6_out, l2_v7_out))
fp.rule(l2_actual_exit(l2_v1_out, l2_v2_out, l2_v3_out, l2_v4_out, l2_v5_out, l2_v6_out, l2_v7_out), l2_actual_exit_rule, name="l2_actual_exit_rule")

# ============================================================
# Target loop: l3
# ============================================================

# Guard
l3_guard = (l3_v7 > IntVal(0))

# Entry states
l3_entry_states_p1 = And(And((l2_v6 >= IntVal(0)), (l2_v6 != IntVal(10)), (l2_v6 != IntVal(8)), (l2_v6 != IntVal(6))), l2_reachable_header_states(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7), (l3_v1 == l2_v1), (l3_v2 == l2_v2), (l3_v3 == l2_v3), (l3_v4 == l2_v4), (l3_v5 == l2_v5), (l3_v6 == l2_v6), (l3_v7 == (l2_v6 + IntVal(2))))
fp.rule(l3_entry_states(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7), l3_entry_states_p1, name="l3_entry_states_p1")

# Iteration steps
l3_iteration_steps_p1 = And(And((l3_v7 > IntVal(0)), (l3_v7 != IntVal(7)), (l3_v7 != IntVal(5)), (l3_v5 == IntVal(0)), (l3_v7 == IntVal(2))), (l3_v1_next == l3_v1), (l3_v2_next == l3_v2), (l3_v3_next == l3_v3), (l3_v4_next == l3_v4), (l3_v5_next == l3_v5), (l3_v6_next == l3_v6), (l3_v7_next == l3_v7))
fp.rule(l3_iteration_steps(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v1_next, l3_v2_next, l3_v3_next, l3_v4_next, l3_v5_next, l3_v6_next, l3_v7_next), l3_iteration_steps_p1, name="l3_iteration_steps_p1")

l3_iteration_steps_p2 = And(Or(Or(Or(And((l3_v7 > IntVal(0)), (l3_v7 != IntVal(7)), (l3_v7 != IntVal(5)), (l3_v5 == IntVal(0)), (l3_v7 != IntVal(2)), ((l3_v7 - IntVal(1)) == IntVal(3))), And((l3_v7 > IntVal(0)), (l3_v7 != IntVal(7)), (l3_v7 != IntVal(5)), (l3_v5 == IntVal(0)), (l3_v7 != IntVal(2)), ((l3_v7 - IntVal(1)) != IntVal(3)))), And((l3_v7 > IntVal(0)), (l3_v7 != IntVal(7)), (l3_v7 != IntVal(5)), (l3_v5 != IntVal(0)), ((l3_v7 - IntVal(1)) == IntVal(3)))), And((l3_v7 > IntVal(0)), (l3_v7 != IntVal(7)), (l3_v7 != IntVal(5)), (l3_v5 != IntVal(0)), ((l3_v7 - IntVal(1)) != IntVal(3)))), (l3_v1_next == l3_v1), (l3_v2_next == l3_v2), (l3_v3_next == l3_v3), (l3_v4_next == l3_v4), (l3_v5_next == l3_v5), (l3_v6_next == l3_v6), (l3_v7_next == (l3_v7 - IntVal(1))))
fp.rule(l3_iteration_steps(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v1_next, l3_v2_next, l3_v3_next, l3_v4_next, l3_v5_next, l3_v6_next, l3_v7_next), l3_iteration_steps_p2, name="l3_iteration_steps_p2")

# Exit steps
l3_exit_steps_p1 = And(Or(And((l3_v7 > IntVal(0)), (l3_v7 != IntVal(7)), (l3_v7 == IntVal(5))), (l3_v7 <= IntVal(0))), (l3_v1_out == l3_v1), (l3_v2_out == l3_v2), (l3_v3_out == l3_v3), (l3_v4_out == l3_v4), (l3_v5_out == l3_v5), (l3_v6_out == l3_v6), (l3_v7_out == l3_v7))
fp.rule(l3_exit_steps(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v1_out, l3_v2_out, l3_v3_out, l3_v4_out, l3_v5_out, l3_v6_out, l3_v7_out), l3_exit_steps_p1, name="l3_exit_steps_p1")

# Return steps
l3_return_steps_p1 = And((l3_v7 > IntVal(0)), (l3_v7 == IntVal(7)))
fp.rule(l3_return_steps(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7), l3_return_steps_p1, name="l3_return_steps_p1")

# Reachable header states
l3_reachable_header_states_base = l3_entry_states(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7)
fp.rule(l3_reachable_header_states(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7), l3_reachable_header_states_base, name="l3_reachable_header_states_base")

l3_reachable_header_states_recursive = And(l3_reachable_header_states(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7), l3_iteration_steps(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v1_next, l3_v2_next, l3_v3_next, l3_v4_next, l3_v5_next, l3_v6_next, l3_v7_next))
fp.rule(l3_reachable_header_states(l3_v1_next, l3_v2_next, l3_v3_next, l3_v4_next, l3_v5_next, l3_v6_next, l3_v7_next), l3_reachable_header_states_recursive, name="l3_reachable_header_states_recursive")

# Header to exit
l3_header_to_exit_base = l3_exit_steps(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v1_out, l3_v2_out, l3_v3_out, l3_v4_out, l3_v5_out, l3_v6_out, l3_v7_out)
fp.rule(l3_header_to_exit(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v1_out, l3_v2_out, l3_v3_out, l3_v4_out, l3_v5_out, l3_v6_out, l3_v7_out), l3_header_to_exit_base, name="l3_header_to_exit_base")

l3_header_to_exit_recursive = And(l3_iteration_steps(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v1_next, l3_v2_next, l3_v3_next, l3_v4_next, l3_v5_next, l3_v6_next, l3_v7_next), l3_header_to_exit(l3_v1_next, l3_v2_next, l3_v3_next, l3_v4_next, l3_v5_next, l3_v6_next, l3_v7_next, l3_v1_out, l3_v2_out, l3_v3_out, l3_v4_out, l3_v5_out, l3_v6_out, l3_v7_out))
fp.rule(l3_header_to_exit(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v1_out, l3_v2_out, l3_v3_out, l3_v4_out, l3_v5_out, l3_v6_out, l3_v7_out), l3_header_to_exit_recursive, name="l3_header_to_exit_recursive")

# Header to return
l3_header_to_return_base = l3_return_steps(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7)
fp.rule(l3_header_to_return(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7), l3_header_to_return_base, name="l3_header_to_return_base")

l3_header_to_return_recursive = And(l3_iteration_steps(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v1_next, l3_v2_next, l3_v3_next, l3_v4_next, l3_v5_next, l3_v6_next, l3_v7_next), l3_header_to_return(l3_v1_next, l3_v2_next, l3_v3_next, l3_v4_next, l3_v5_next, l3_v6_next, l3_v7_next))
fp.rule(l3_header_to_return(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7), l3_header_to_return_recursive, name="l3_header_to_return_recursive")

# Actual exit
l3_actual_exit_rule = And(l3_entry_states(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7), l3_header_to_exit(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v1_out, l3_v2_out, l3_v3_out, l3_v4_out, l3_v5_out, l3_v6_out, l3_v7_out))
fp.rule(l3_actual_exit(l3_v1_out, l3_v2_out, l3_v3_out, l3_v4_out, l3_v5_out, l3_v6_out, l3_v7_out), l3_actual_exit_rule, name="l3_actual_exit_rule")

# ============================================================
# Target candidate: l3 (non-terminating)
# ============================================================

l3_recurrent_set = And((l3_v7 == IntVal(2)), (l3_v5 == IntVal(0)))
l3_recurrent_set_next = And((l3_v7_next == IntVal(2)), (l3_v5_next == IntVal(0)))

# ============================================================
# Non-termination validation
# ============================================================

l3_reachable_recurrent_set = Function("l3_reachable_recurrent_set", BoolSort())
fp.register_relation(l3_reachable_recurrent_set)
fp.rule(l3_reachable_recurrent_set(), And(l3_reachable_header_states(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7), l3_recurrent_set), name="l3_reachable_recurrent_set_rule")

l3_recurrent_guard_solver = Solver()
l3_recurrent_guard_solver.add(l3_recurrent_set, Not(l3_guard))

l3_bad_recurrent_closure = Function("l3_bad_recurrent_closure", BoolSort())
fp.register_relation(l3_bad_recurrent_closure)
fp.rule(l3_bad_recurrent_closure(), And(l3_recurrent_set, l3_iteration_steps(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v1_next, l3_v2_next, l3_v3_next, l3_v4_next, l3_v5_next, l3_v6_next, l3_v7_next), Not(l3_recurrent_set_next)), name="l3_bad_recurrent_closure_rule")

l3_bad_recurrent_exit = Function("l3_bad_recurrent_exit", BoolSort())
fp.register_relation(l3_bad_recurrent_exit)
fp.rule(l3_bad_recurrent_exit(), And(l3_recurrent_set, l3_exit_steps(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v1_out, l3_v2_out, l3_v3_out, l3_v4_out, l3_v5_out, l3_v6_out, l3_v7_out)), name="l3_bad_recurrent_exit_rule")

l3_bad_recurrent_return = Function("l3_bad_recurrent_return", BoolSort())
fp.register_relation(l3_bad_recurrent_return)
fp.rule(l3_bad_recurrent_return(), And(l3_recurrent_set, l3_return_steps(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7)), name="l3_bad_recurrent_return_rule")

def check_fixedpoint(name, relation, expected):
    result = fp.query(relation())
    print(f'{name}: "{result}"')
    if result != expected and result == sat:
        print(f'COUNTEREXAMPLE_BEGIN: "{name}"')
        try:
            print(fp.get_ground_sat_answer())
        except Exception:
            try:
                print(fp.get_answer())
            except Exception as ex:
                print(f'Could not extract Spacer counterexample: {ex}')
        print(f'COUNTEREXAMPLE_END: "{name}"')
    if result == unknown:
        print(f'DETAIL_BEGIN: "{name}"')
        try:
            print(fp.reason_unknown())
        except Exception as ex:
            print(f'Z3 returned unknown: {ex}')
        print(f'DETAIL_END: "{name}"')

    return result

def check_solver(name, solver, expected):
    result = solver.check()
    print(f'{name}: "{result}"')
    if result != expected and result == sat:
        print(f'COUNTEREXAMPLE_BEGIN: "{name}"')
        print(solver.model())
        print(f'COUNTEREXAMPLE_END: "{name}"')
    if result == unknown:
        print(f'DETAIL_BEGIN: "{name}"')
        print(solver.reason_unknown())
        print(f'DETAIL_END: "{name}"')
    return result

def validation_status(checks):
    saw_unknown = False
    for result, expected in checks:
        if result == unknown:
            saw_unknown = True
        elif result != expected:
            return "invalid"
    return "unknown" if saw_unknown else "valid"

l3_recurrent_reachability_result = check_fixedpoint(
    "RECURRENT_REACHABILITY",
    l3_reachable_recurrent_set,
    sat
)

l3_recurrent_guard_result = check_solver(
    "RECURRENT_GUARD_CONTAINMENT",
    l3_recurrent_guard_solver,
    unsat
)

l3_recurrent_closure_result = check_fixedpoint(
    "RECURRENT_CLOSURE",
    l3_bad_recurrent_closure,
    unsat
)

l3_recurrent_exit_result = check_fixedpoint(
    "RECURRENT_NO_NORMAL_EXIT",
    l3_bad_recurrent_exit,
    unsat
)

l3_recurrent_return_result = check_fixedpoint(
    "RECURRENT_NO_FUNCTION_RETURN",
    l3_bad_recurrent_return,
    unsat
)

RECURRENT_SET_RESULT = validation_status([
    (l3_recurrent_reachability_result, sat),
    (l3_recurrent_guard_result, unsat),
    (l3_recurrent_closure_result, unsat),
    (l3_recurrent_exit_result, unsat),
    (l3_recurrent_return_result, unsat)
])

print()
print(f'RECURRENT_SET_RESULT: "{RECURRENT_SET_RESULT}"')
