print('===================== SEMANTIC FEEDBACK =====================')
print('TARGET_LOOP: l1')
print('CANDIDATE_KIND: non-terminating')
print()
print('RECURRENT_SET:')
print("{\n  \"op\": \"and\",\n  \"args\": [\n    {\n      \"op\": \"!=\",\n      \"args\": [\n        \"l1_v2\",\n        0\n      ]\n    },\n    {\n      \"op\": \"and\",\n      \"args\": [\n        {\n          \"op\": \"!=\",\n          \"args\": [\n            \"l1_v2\",\n            1\n          ]\n        },\n        {\n          \"op\": \"or\",\n          \"args\": [\n            {\n              \"op\": \">\",\n              \"args\": [\n                \"l1_v2\",\n                \"l1_v3\"\n              ]\n            },\n            {\n              \"op\": \"<\",\n              \"args\": [\n                \"l1_v2\",\n                {\n                  \"op\": \"neg\",\n                  \"args\": [\n                    \"l1_v3\"\n                  ]\n                }\n              ]\n            }\n          ]\n        }\n      ]\n    }\n  ]\n}")
print()
print('FEEDBACK:')
#!/usr/bin/env python3

from z3 import *
import sys
import time

VALIDATION_TIMEOUT_MS = 266321
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
l1_state = [l1_v1, l1_v2, l1_v3]
l1_next_state = [l1_v1_next, l1_v2_next, l1_v3_next]
l1_output_state = [l1_v1_out, l1_v2_out, l1_v3_out]

# Nondeterministic symbols
l1_nd1 = Int("l1_nd1")
fp.declare_var(l1_nd1)

# ============================================================
# Relation declarations
# ============================================================

# l1
l1_entry_states = Function("l1_entry_states", IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_entry_states)
l1_iteration_steps = Function("l1_iteration_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_iteration_steps)
l1_exit_steps = Function("l1_exit_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_exit_steps)
l1_return_steps = Function("l1_return_steps", IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_return_steps)
l1_reachable_header_states = Function("l1_reachable_header_states", IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_reachable_header_states)
l1_header_to_exit = Function("l1_header_to_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_header_to_exit)
l1_header_to_return = Function("l1_header_to_return", IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_header_to_return)
l1_actual_exit = Function("l1_actual_exit", IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_actual_exit)

# ============================================================
# Target loop: l1
# ============================================================

# Guard
l1_guard = Not((l1_v2 == IntVal(0)))

# Entry states
l1_entry_states_p1 = And(BoolVal(True), (l1_v1 == IntVal(0)), (l1_v2 == l1_nd1), (l1_v3 == IntVal(5)))
fp.rule(l1_entry_states(l1_v1, l1_v2, l1_v3), l1_entry_states_p1, name="l1_entry_states_p1")

# Iteration steps
l1_iteration_steps_p1 = And(And((l1_v2 != IntVal(0)), (l1_v2 < (IntVal(0) - l1_v3))), (l1_v1_next == l1_v1), (l1_v2_next == ((l1_v2 - IntVal(1)) * IntVal(-1))), (l1_v3_next == (l1_v3 + IntVal(1))))
fp.rule(l1_iteration_steps(l1_v1, l1_v2, l1_v3, l1_v1_next, l1_v2_next, l1_v3_next), l1_iteration_steps_p1, name="l1_iteration_steps_p1")

l1_iteration_steps_p2 = And(And((l1_v2 != IntVal(0)), (l1_v2 >= (IntVal(0) - l1_v3)), (l1_v2 > l1_v3)), (l1_v1_next == l1_v1), (l1_v2_next == ((l1_v2 + IntVal(1)) * IntVal(-1))), (l1_v3_next == (l1_v3 + IntVal(1))))
fp.rule(l1_iteration_steps(l1_v1, l1_v2, l1_v3, l1_v1_next, l1_v2_next, l1_v3_next), l1_iteration_steps_p2, name="l1_iteration_steps_p2")

l1_iteration_steps_p3 = And(And((l1_v2 != IntVal(0)), (l1_v2 >= (IntVal(0) - l1_v3)), (l1_v2 <= l1_v3)), (l1_v1_next == l1_v1), (l1_v2_next == IntVal(0)), (l1_v3_next == (l1_v3 + IntVal(1))))
fp.rule(l1_iteration_steps(l1_v1, l1_v2, l1_v3, l1_v1_next, l1_v2_next, l1_v3_next), l1_iteration_steps_p3, name="l1_iteration_steps_p3")

# Exit steps
l1_exit_steps_p1 = And((l1_v2 == IntVal(0)), (l1_v1_out == l1_v1), (l1_v2_out == l1_v2), (l1_v3_out == l1_v3))
fp.rule(l1_exit_steps(l1_v1, l1_v2, l1_v3, l1_v1_out, l1_v2_out, l1_v3_out), l1_exit_steps_p1, name="l1_exit_steps_p1")

# Return steps
# Reachable header states
l1_reachable_header_states_base = l1_entry_states(l1_v1, l1_v2, l1_v3)
fp.rule(l1_reachable_header_states(l1_v1, l1_v2, l1_v3), l1_reachable_header_states_base, name="l1_reachable_header_states_base")

l1_reachable_header_states_recursive = And(l1_reachable_header_states(l1_v1, l1_v2, l1_v3), l1_iteration_steps(l1_v1, l1_v2, l1_v3, l1_v1_next, l1_v2_next, l1_v3_next))
fp.rule(l1_reachable_header_states(l1_v1_next, l1_v2_next, l1_v3_next), l1_reachable_header_states_recursive, name="l1_reachable_header_states_recursive")

# Header to exit
l1_header_to_exit_base = l1_exit_steps(l1_v1, l1_v2, l1_v3, l1_v1_out, l1_v2_out, l1_v3_out)
fp.rule(l1_header_to_exit(l1_v1, l1_v2, l1_v3, l1_v1_out, l1_v2_out, l1_v3_out), l1_header_to_exit_base, name="l1_header_to_exit_base")

l1_header_to_exit_recursive = And(l1_iteration_steps(l1_v1, l1_v2, l1_v3, l1_v1_next, l1_v2_next, l1_v3_next), l1_header_to_exit(l1_v1_next, l1_v2_next, l1_v3_next, l1_v1_out, l1_v2_out, l1_v3_out))
fp.rule(l1_header_to_exit(l1_v1, l1_v2, l1_v3, l1_v1_out, l1_v2_out, l1_v3_out), l1_header_to_exit_recursive, name="l1_header_to_exit_recursive")

# Header to return
l1_header_to_return_base = l1_return_steps(l1_v1, l1_v2, l1_v3)
fp.rule(l1_header_to_return(l1_v1, l1_v2, l1_v3), l1_header_to_return_base, name="l1_header_to_return_base")

l1_header_to_return_recursive = And(l1_iteration_steps(l1_v1, l1_v2, l1_v3, l1_v1_next, l1_v2_next, l1_v3_next), l1_header_to_return(l1_v1_next, l1_v2_next, l1_v3_next))
fp.rule(l1_header_to_return(l1_v1, l1_v2, l1_v3), l1_header_to_return_recursive, name="l1_header_to_return_recursive")

# Actual exit
l1_actual_exit_rule = And(l1_entry_states(l1_v1, l1_v2, l1_v3), l1_header_to_exit(l1_v1, l1_v2, l1_v3, l1_v1_out, l1_v2_out, l1_v3_out))
fp.rule(l1_actual_exit(l1_v1_out, l1_v2_out, l1_v3_out), l1_actual_exit_rule, name="l1_actual_exit_rule")

# ============================================================
# Target candidate: l1 (non-terminating)
# ============================================================

l1_recurrent_set = And((l1_v2 != IntVal(0)), And((l1_v2 != IntVal(1)), Or((l1_v2 > l1_v3), (l1_v2 < (-l1_v3)))))
l1_recurrent_set_next = And((l1_v2_next != IntVal(0)), And((l1_v2_next != IntVal(1)), Or((l1_v2_next > l1_v3_next), (l1_v2_next < (-l1_v3_next)))))

# ============================================================
# Non-termination validation
# ============================================================

l1_reachable_recurrent_set = Function("l1_reachable_recurrent_set", BoolSort())
fp.register_relation(l1_reachable_recurrent_set)
fp.rule(l1_reachable_recurrent_set(), And(l1_reachable_header_states(l1_v1, l1_v2, l1_v3), l1_recurrent_set), name="l1_reachable_recurrent_set_rule")

l1_recurrent_guard_solver = Solver()
l1_recurrent_guard_solver.add(l1_recurrent_set, Not(l1_guard))

l1_bad_recurrent_closure = Function("l1_bad_recurrent_closure", BoolSort())
fp.register_relation(l1_bad_recurrent_closure)
fp.rule(l1_bad_recurrent_closure(), And(l1_recurrent_set, l1_iteration_steps(l1_v1, l1_v2, l1_v3, l1_v1_next, l1_v2_next, l1_v3_next), Not(l1_recurrent_set_next)), name="l1_bad_recurrent_closure_rule")

l1_bad_recurrent_exit = Function("l1_bad_recurrent_exit", BoolSort())
fp.register_relation(l1_bad_recurrent_exit)
fp.rule(l1_bad_recurrent_exit(), And(l1_recurrent_set, l1_exit_steps(l1_v1, l1_v2, l1_v3, l1_v1_out, l1_v2_out, l1_v3_out)), name="l1_bad_recurrent_exit_rule")

l1_bad_recurrent_return = Function("l1_bad_recurrent_return", BoolSort())
fp.register_relation(l1_bad_recurrent_return)
fp.rule(l1_bad_recurrent_return(), And(l1_recurrent_set, l1_return_steps(l1_v1, l1_v2, l1_v3)), name="l1_bad_recurrent_return_rule")

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

l1_recurrent_reachability_result = check_fixedpoint(
    "RECURRENT_REACHABILITY",
    l1_reachable_recurrent_set,
    sat,
    "no reachable loop-header state belongs to the recurrent set."
)

l1_recurrent_guard_result = check_solver(
    "RECURRENT_GUARD_CONTAINMENT",
    l1_recurrent_guard_solver,
    unsat,
    "a recurrent-set state can violate the loop guard."
)

l1_recurrent_closure_result = check_fixedpoint(
    "RECURRENT_CLOSURE",
    l1_bad_recurrent_closure,
    unsat,
    "a completed loop iteration can leave the recurrent set."
)

l1_recurrent_exit_result = check_fixedpoint(
    "RECURRENT_NO_NORMAL_EXIT",
    l1_bad_recurrent_exit,
    unsat,
    "a recurrent-set state can permit normal loop exit."
)

l1_recurrent_return_result = check_fixedpoint(
    "RECURRENT_NO_FUNCTION_RETURN",
    l1_bad_recurrent_return,
    unsat,
    "a recurrent-set state can permit function return."
)

RECURRENT_SET_RESULT = validation_status([
    (l1_recurrent_reachability_result, sat),
    (l1_recurrent_guard_result, unsat),
    (l1_recurrent_closure_result, unsat),
    (l1_recurrent_exit_result, unsat),
    (l1_recurrent_return_result, unsat)
])

print()
print(f'RECURRENT_SET_RESULT: "{RECURRENT_SET_RESULT}"')
