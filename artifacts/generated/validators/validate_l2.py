print('===================== SEMANTIC FEEDBACK =====================')
print('TARGET_LOOP: l2')
print('CANDIDATE_KIND: terminating')
print()
print('INVARIANT:')
print("\"true\"")
print()
print('RANKING_FUNCTION:')
print("{\n  \"op\": \"max\",\n  \"args\": [\n    \"l2_v4\",\n    0\n  ]\n}")
print()
print('FEEDBACK:')
#!/usr/bin/env python3

from z3 import *
import sys
import time

VALIDATION_TIMEOUT_MS = 555278
VALIDATION_DEADLINE = (
    time.monotonic() + VALIDATION_TIMEOUT_MS / 1000.0
    if VALIDATION_TIMEOUT_MS > 0
    else None
)

def remaining_timeout_ms():
    if VALIDATION_DEADLINE is None:
        return 0
    remaining = int((VALIDATION_DEADLINE - time.monotonic()) * 1000)
    if remaining <= 0:
        sys.exit(124)
    return max(1, remaining)

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
l1_state = [l1_v1, l1_v2, l1_v3, l1_v4]
l1_next_state = [l1_v1_next, l1_v2_next, l1_v3_next, l1_v4_next]
l1_output_state = [l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out]

# Nondeterministic symbols
l1_nd1 = Int("l1_nd1")
fp.declare_var(l1_nd1)
l1_nd2 = Int("l1_nd2")
fp.declare_var(l1_nd2)
l1_nd3 = Int("l1_nd3")
fp.declare_var(l1_nd3)

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
l2_state = [l2_v1, l2_v2, l2_v3, l2_v4]
l2_next_state = [l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next]
l2_output_state = [l2_v1_out, l2_v2_out, l2_v3_out, l2_v4_out]

# ============================================================
# Relation declarations
# ============================================================

# l1
l1_entry_states = Function("l1_entry_states", IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_entry_states)
l1_iteration_steps = Function("l1_iteration_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_iteration_steps)
l1_exit_steps = Function("l1_exit_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_exit_steps)
l1_return_steps = Function("l1_return_steps", IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_return_steps)
l1_reachable_header_states = Function("l1_reachable_header_states", IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_reachable_header_states)
l1_header_to_exit = Function("l1_header_to_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_header_to_exit)
l1_header_to_return = Function("l1_header_to_return", IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_header_to_return)
l1_actual_exit = Function("l1_actual_exit", IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_actual_exit)

# l2
l2_entry_states = Function("l2_entry_states", IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l2_entry_states)
l2_iteration_steps = Function("l2_iteration_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l2_iteration_steps)
l2_exit_steps = Function("l2_exit_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l2_exit_steps)
l2_return_steps = Function("l2_return_steps", IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l2_return_steps)
l2_reachable_header_states = Function("l2_reachable_header_states", IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l2_reachable_header_states)
l2_header_to_exit = Function("l2_header_to_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l2_header_to_exit)
l2_header_to_return = Function("l2_header_to_return", IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l2_header_to_return)
l2_actual_exit = Function("l2_actual_exit", IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l2_actual_exit)

# ============================================================
# Dependency loop: l1
# ============================================================

# Guard
l1_guard = (l1_v1 > IntVal(0))

# Entry states
fp.declare_var(Int("arg0"))
fp.declare_var(Int("arg1"))
fp.declare_var(Int("arg2"))
l1_entry_states_p1 = And(BoolVal(True), (l1_v1 == Int("arg0")), (l1_v2 == Int("arg1")), (l1_v3 == Int("arg2")), (l1_v4 == IntVal(0)))
fp.rule(l1_entry_states(l1_v1, l1_v2, l1_v3, l1_v4), l1_entry_states_p1, name="l1_entry_states_p1")

# Iteration steps
l1_iteration_steps_p1 = And(And((l1_v1 > IntVal(0)), (l1_nd1 != IntVal(0))), (l1_v1_next == (l1_v1 + IntVal(-1))), (l1_v2_next == (l1_v2 + l1_v3)), (l1_v3_next == l1_v3), (l1_v4_next == (l1_v2 + l1_v3)))
fp.rule(l1_iteration_steps(l1_v1, l1_v2, l1_v3, l1_v4, l1_v1_next, l1_v2_next, l1_v3_next, l1_v4_next), l1_iteration_steps_p1, name="l1_iteration_steps_p1")

l1_iteration_steps_p2 = And(And((l1_v1 > IntVal(0)), (l1_nd1 == IntVal(0))), (l1_v1_next == (l1_v1 + IntVal(-1))), (l1_v2_next == l1_v3), (l1_v3_next == l1_v3), (l1_v4_next == (l1_v2 + l1_v3)))
fp.rule(l1_iteration_steps(l1_v1, l1_v2, l1_v3, l1_v4, l1_v1_next, l1_v2_next, l1_v3_next, l1_v4_next), l1_iteration_steps_p2, name="l1_iteration_steps_p2")

# Exit steps
l1_exit_steps_p1 = And((l1_v1 <= IntVal(0)), (l1_v1_out == (l1_v1 + IntVal(-1))), (l1_v2_out == l1_v2), (l1_v3_out == l1_v3), (l1_v4_out == l1_v4))
fp.rule(l1_exit_steps(l1_v1, l1_v2, l1_v3, l1_v4, l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out), l1_exit_steps_p1, name="l1_exit_steps_p1")

# Return steps
# Reachable header states
l1_reachable_header_states_base = l1_entry_states(l1_v1, l1_v2, l1_v3, l1_v4)
fp.rule(l1_reachable_header_states(l1_v1, l1_v2, l1_v3, l1_v4), l1_reachable_header_states_base, name="l1_reachable_header_states_base")

l1_reachable_header_states_recursive = And(l1_reachable_header_states(l1_v1, l1_v2, l1_v3, l1_v4), l1_iteration_steps(l1_v1, l1_v2, l1_v3, l1_v4, l1_v1_next, l1_v2_next, l1_v3_next, l1_v4_next))
fp.rule(l1_reachable_header_states(l1_v1_next, l1_v2_next, l1_v3_next, l1_v4_next), l1_reachable_header_states_recursive, name="l1_reachable_header_states_recursive")

# Header to exit
l1_header_to_exit_base = l1_exit_steps(l1_v1, l1_v2, l1_v3, l1_v4, l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out)
fp.rule(l1_header_to_exit(l1_v1, l1_v2, l1_v3, l1_v4, l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out), l1_header_to_exit_base, name="l1_header_to_exit_base")

l1_header_to_exit_recursive = And(l1_iteration_steps(l1_v1, l1_v2, l1_v3, l1_v4, l1_v1_next, l1_v2_next, l1_v3_next, l1_v4_next), l1_header_to_exit(l1_v1_next, l1_v2_next, l1_v3_next, l1_v4_next, l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out))
fp.rule(l1_header_to_exit(l1_v1, l1_v2, l1_v3, l1_v4, l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out), l1_header_to_exit_recursive, name="l1_header_to_exit_recursive")

# Header to return
l1_header_to_return_base = l1_return_steps(l1_v1, l1_v2, l1_v3, l1_v4)
fp.rule(l1_header_to_return(l1_v1, l1_v2, l1_v3, l1_v4), l1_header_to_return_base, name="l1_header_to_return_base")

l1_header_to_return_recursive = And(l1_iteration_steps(l1_v1, l1_v2, l1_v3, l1_v4, l1_v1_next, l1_v2_next, l1_v3_next, l1_v4_next), l1_header_to_return(l1_v1_next, l1_v2_next, l1_v3_next, l1_v4_next))
fp.rule(l1_header_to_return(l1_v1, l1_v2, l1_v3, l1_v4), l1_header_to_return_recursive, name="l1_header_to_return_recursive")

# Actual exit
l1_actual_exit_rule = And(l1_entry_states(l1_v1, l1_v2, l1_v3, l1_v4), l1_header_to_exit(l1_v1, l1_v2, l1_v3, l1_v4, l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out))
fp.rule(l1_actual_exit(l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out), l1_actual_exit_rule, name="l1_actual_exit_rule")

# ============================================================
# Target loop: l2
# ============================================================

# Guard
l2_guard = (l2_v4 > IntVal(0))

# Entry states
l2_entry_states_p1 = And(BoolVal(True), l1_actual_exit(l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out), (l2_v1 == l1_v1_out), (l2_v2 == l1_v2_out), (l2_v3 == l1_v3_out), (l2_v4 == l1_v4_out))
fp.rule(l2_entry_states(l2_v1, l2_v2, l2_v3, l2_v4), l2_entry_states_p1, name="l2_entry_states_p1")

# Iteration steps
l2_iteration_steps_p1 = And((l2_v4 > IntVal(0)), (l2_v1_next == l2_v1), (l2_v2_next == l2_v2), (l2_v3_next == l2_v3), (l2_v4_next == (l2_v4 + IntVal(-1))))
fp.rule(l2_iteration_steps(l2_v1, l2_v2, l2_v3, l2_v4, l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next), l2_iteration_steps_p1, name="l2_iteration_steps_p1")

# Exit steps
l2_exit_steps_p1 = And((l2_v4 <= IntVal(0)), (l2_v1_out == l2_v1), (l2_v2_out == l2_v2), (l2_v3_out == l2_v3), (l2_v4_out == l2_v4))
fp.rule(l2_exit_steps(l2_v1, l2_v2, l2_v3, l2_v4, l2_v1_out, l2_v2_out, l2_v3_out, l2_v4_out), l2_exit_steps_p1, name="l2_exit_steps_p1")

# Return steps
# Reachable header states
l2_reachable_header_states_base = l2_entry_states(l2_v1, l2_v2, l2_v3, l2_v4)
fp.rule(l2_reachable_header_states(l2_v1, l2_v2, l2_v3, l2_v4), l2_reachable_header_states_base, name="l2_reachable_header_states_base")

l2_reachable_header_states_recursive = And(l2_reachable_header_states(l2_v1, l2_v2, l2_v3, l2_v4), l2_iteration_steps(l2_v1, l2_v2, l2_v3, l2_v4, l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next))
fp.rule(l2_reachable_header_states(l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next), l2_reachable_header_states_recursive, name="l2_reachable_header_states_recursive")

# Header to exit
l2_header_to_exit_base = l2_exit_steps(l2_v1, l2_v2, l2_v3, l2_v4, l2_v1_out, l2_v2_out, l2_v3_out, l2_v4_out)
fp.rule(l2_header_to_exit(l2_v1, l2_v2, l2_v3, l2_v4, l2_v1_out, l2_v2_out, l2_v3_out, l2_v4_out), l2_header_to_exit_base, name="l2_header_to_exit_base")

l2_header_to_exit_recursive = And(l2_iteration_steps(l2_v1, l2_v2, l2_v3, l2_v4, l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next), l2_header_to_exit(l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next, l2_v1_out, l2_v2_out, l2_v3_out, l2_v4_out))
fp.rule(l2_header_to_exit(l2_v1, l2_v2, l2_v3, l2_v4, l2_v1_out, l2_v2_out, l2_v3_out, l2_v4_out), l2_header_to_exit_recursive, name="l2_header_to_exit_recursive")

# Header to return
l2_header_to_return_base = l2_return_steps(l2_v1, l2_v2, l2_v3, l2_v4)
fp.rule(l2_header_to_return(l2_v1, l2_v2, l2_v3, l2_v4), l2_header_to_return_base, name="l2_header_to_return_base")

l2_header_to_return_recursive = And(l2_iteration_steps(l2_v1, l2_v2, l2_v3, l2_v4, l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next), l2_header_to_return(l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next))
fp.rule(l2_header_to_return(l2_v1, l2_v2, l2_v3, l2_v4), l2_header_to_return_recursive, name="l2_header_to_return_recursive")

# Actual exit
l2_actual_exit_rule = And(l2_entry_states(l2_v1, l2_v2, l2_v3, l2_v4), l2_header_to_exit(l2_v1, l2_v2, l2_v3, l2_v4, l2_v1_out, l2_v2_out, l2_v3_out, l2_v4_out))
fp.rule(l2_actual_exit(l2_v1_out, l2_v2_out, l2_v3_out, l2_v4_out), l2_actual_exit_rule, name="l2_actual_exit_rule")

# ============================================================
# Target candidate: l2 (terminating)
# ============================================================

l2_invariant = BoolVal(True)
l2_invariant_next = BoolVal(True)

l2_ranking_function = [If(l2_v4 >= IntVal(0), l2_v4, IntVal(0))]
l2_ranking_function_next = [If(l2_v4_next >= IntVal(0), l2_v4_next, IntVal(0))]

# ============================================================
# Termination validation
# ============================================================

l2_bad_invariant_initialization = Function("l2_bad_invariant_initialization", BoolSort())
fp.register_relation(l2_bad_invariant_initialization)
fp.rule(l2_bad_invariant_initialization(), And(l2_entry_states(l2_v1, l2_v2, l2_v3, l2_v4), Not(l2_invariant)), name="l2_bad_invariant_initialization_rule")

l2_bad_invariant_preservation = Function("l2_bad_invariant_preservation", BoolSort())
fp.register_relation(l2_bad_invariant_preservation)
fp.rule(l2_bad_invariant_preservation(), And(l2_invariant, l2_guard, l2_iteration_steps(l2_v1, l2_v2, l2_v3, l2_v4, l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next), Not(l2_invariant_next)), name="l2_bad_invariant_preservation_rule")

l2_ranking_nonnegativity_solver = Solver()
l2_ranking_nonnegativity_solver.add(l2_invariant, l2_guard, l2_ranking_function[0] < 0)

l2_ranking_decrease_solver = Solver()
l2_ranking_decrease_solver.add(l2_invariant, l2_guard, l2_iteration_steps_p1, Not(l2_ranking_function_next[0] < l2_ranking_function[0]))

def report_result(name, result, expected, failure_message):
    if result == unknown:
        print(f'{name}: unknown')
    elif result == expected:
        print(f'{name}: passed')
    else:
        print(f'{name}: failed - {failure_message}')

def check_fixedpoint(name, relation, expected, failure_message):
    remaining = remaining_timeout_ms()
    if remaining > 0:
        fp.set(timeout=remaining)

    try:
        result = fp.query(relation())
    except Z3Exception as ex:
        reason = str(ex).lower()
        if "timeout" in reason or "canceled" in reason:
            sys.exit(124)
        raise

    if result == unknown:
        try:
            reason = str(fp.reason_unknown()).lower()
        except Exception:
            reason = ""

        if "timeout" in reason or "canceled" in reason:
            sys.exit(124)

    report_result(name, result, expected, failure_message)

    if result != expected and result == sat:
        print('COUNTEREXAMPLE:')
        try:
            answer = fp.get_ground_sat_answer()
            if str(answer) == "False":
                answer = fp.get_answer()
            print(answer)
        except Exception:
            try:
                print(fp.get_answer())
            except Exception as ex:
                print(f'Could not extract counterexample: {ex}')

    if result == unknown:
        print('DETAIL:')
        try:
            print(fp.reason_unknown())
        except Exception as ex:
            print(f'Z3 returned unknown: {ex}')

    print()
    return result

def check_solver(name, solver, expected, failure_message):
    remaining = remaining_timeout_ms()
    if remaining > 0:
        solver.set(timeout=remaining)

    try:
        result = solver.check()
    except Z3Exception as ex:
        reason = str(ex).lower()
        if "timeout" in reason or "canceled" in reason:
            sys.exit(124)
        raise

    if result == unknown:
        reason = str(solver.reason_unknown()).lower()

        if "timeout" in reason or "canceled" in reason:
            sys.exit(124)

    report_result(name, result, expected, failure_message)

    if result != expected and result == sat:
        print('COUNTEREXAMPLE:')
        print(solver.model())

    if result == unknown:
        print('DETAIL:')
        print(solver.reason_unknown())

    print()
    return result

def validation_status(checks):
    saw_unknown = False
    for result, expected in checks:
        if result == unknown:
            saw_unknown = True
        elif result != expected:
            return "invalid"
    return "unknown" if saw_unknown else "valid"

l2_invariant_initialization_result = check_fixedpoint(
    "INVARIANT_INITIALIZATION",
    l2_bad_invariant_initialization,
    unsat,
    "a reachable entry state violates the invariant."
)

l2_invariant_preservation_result = check_fixedpoint(
    "INVARIANT_PRESERVATION",
    l2_bad_invariant_preservation,
    unsat,
    "a completed loop iteration can reach a next state that violates the invariant."
)

l2_ranking_nonnegativity_result = check_solver(
    "RANKING_NONNEGATIVITY",
    l2_ranking_nonnegativity_solver,
    unsat,
    "the ranking function can be negative while the invariant and loop guard hold."
)

l2_ranking_decrease_result = check_solver(
    "RANKING_DECREASE",
    l2_ranking_decrease_solver,
    unsat,
    "a completed loop iteration can fail to strictly decrease the ranking function."
)

INVARIANT_RESULT = validation_status([
    (l2_invariant_initialization_result, unsat),
    (l2_invariant_preservation_result, unsat)
])

RANKING_FUNCTION_RESULT = validation_status([
    (l2_ranking_nonnegativity_result, unsat),
    (l2_ranking_decrease_result, unsat)
])

print()
print(f'INVARIANT_RESULT: "{INVARIANT_RESULT}"')
print(f'RANKING_FUNCTION_RESULT: "{RANKING_FUNCTION_RESULT}"')
