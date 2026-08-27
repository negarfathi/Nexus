print('===================== SEMANTIC FEEDBACK =====================')
print('TARGET_LOOP: l1')
print('CANDIDATE_KIND: terminating')
print()
print('INVARIANT:')
print("{\n  \"op\": \"<=\",\n  \"args\": [\n    \"l1_v2\",\n    10\n  ]\n}")
print()
print('RANKING_FUNCTION:')
print("\"l1_v2\"")
print()
print('FEEDBACK:')
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

# ============================================================
# Target loop: l1
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
# Target candidate: l1 (terminating)
# ============================================================

l1_invariant = (l1_v2 <= IntVal(10))
l1_invariant_next = (l1_v2_next <= IntVal(10))

l1_ranking_function = [l1_v2]
l1_ranking_function_next = [l1_v2_next]

# ============================================================
# Termination validation
# ============================================================

l1_bad_invariant_initialization = Function("l1_bad_invariant_initialization", BoolSort())
fp.register_relation(l1_bad_invariant_initialization)
fp.rule(l1_bad_invariant_initialization(), And(l1_entry_states(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7), Not(l1_invariant)), name="l1_bad_invariant_initialization_rule")

l1_bad_invariant_preservation = Function("l1_bad_invariant_preservation", BoolSort())
fp.register_relation(l1_bad_invariant_preservation)
fp.rule(l1_bad_invariant_preservation(), And(l1_invariant, l1_guard, l1_iteration_steps(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v1_next, l1_v2_next, l1_v3_next, l1_v4_next, l1_v5_next, l1_v6_next, l1_v7_next), Not(l1_invariant_next)), name="l1_bad_invariant_preservation_rule")

l1_ranking_nonnegativity_solver = Solver()
l1_ranking_nonnegativity_solver.add(l1_invariant, l1_guard, l1_ranking_function[0] < 0)

l1_ranking_decrease_solver = Solver()
l1_ranking_decrease_solver.add(l1_invariant, l1_guard, Or(l1_iteration_steps_p1, l1_iteration_steps_p2), Not(l1_ranking_function_next[0] < l1_ranking_function[0]))

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

l1_invariant_initialization_result = check_fixedpoint(
    "INVARIANT_INITIALIZATION",
    l1_bad_invariant_initialization,
    unsat
)

l1_invariant_preservation_result = check_fixedpoint(
    "INVARIANT_PRESERVATION",
    l1_bad_invariant_preservation,
    unsat
)

l1_ranking_nonnegativity_result = check_solver(
    "RANKING_NONNEGATIVITY",
    l1_ranking_nonnegativity_solver,
    unsat
)

l1_ranking_decrease_result = check_solver(
    "RANKING_DECREASE",
    l1_ranking_decrease_solver,
    unsat
)

INVARIANT_RESULT = validation_status([
    (l1_invariant_initialization_result, unsat),
    (l1_invariant_preservation_result, unsat)
])

RANKING_FUNCTION_RESULT = validation_status([
    (l1_ranking_nonnegativity_result, unsat),
    (l1_ranking_decrease_result, unsat)
])

print()
print(f'INVARIANT_RESULT: "{INVARIANT_RESULT}"')
print(f'RANKING_FUNCTION_RESULT: "{RANKING_FUNCTION_RESULT}"')
