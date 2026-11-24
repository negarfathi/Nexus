print('===================== SEMANTIC FEEDBACK =====================')
print('TARGET_LOOP: l2')
print('CANDIDATE_KIND: non-terminating')
print()
print('RECURRENT_SET:')
print("{\n  \"op\": \"and\",\n  \"args\": [\n    {\n      \"op\": \"<=\",\n      \"args\": [\n        \"l2_v1\",\n        -1\n      ]\n    },\n    {\n      \"op\": \"<=\",\n      \"args\": [\n        \"l2_v6\",\n        -1\n      ]\n    }\n  ]\n}")
print()
print('FEEDBACK:')
#!/usr/bin/env python3

from z3 import *
import sys
import time
import json

VALIDATION_TIMEOUT_MS = 470341
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

def recover_incomplete_z3_query(name, error):
    reason = str(error).lower()
    if "timeout" in reason or "canceled" in reason or "cancelled" in reason:
        sys.exit(124)
    if "stuck on a lemma" in reason:
        print(f'{name}: unknown')
        print('DETAIL:')
        print(f'Z3 Spacer could not complete this query: {error}')
        print()
        return unknown
    return None

VALIDATION_CHECKS = []

def _nexus_safe_text(value, limit=4000):
    return str(value)[:limit]

def record_validation_check(name, result, expected, failure_message, source, source_kind,
                            detail=None, query=None):
    observed = str(result)
    record = {
        "name": name,
        "status": "unknown" if result == unknown else ("valid" if result == expected else "invalid"),
        "expected": str(expected),
        "observed": observed,
        "description": failure_message
    }
    # >>> NEXUS CHANGE BEGIN [6.7 - expose the relevant verification query]
    try:
        condition = query if query is not None else (source.assertions() if source_kind == "solver" else None)
        if condition is not None:
            record["query_condition"] = _nexus_safe_text(condition, 3000)
    except Exception:
        pass  # A missing query string is not a different Z3 outcome.
    # <<< NEXUS CHANGE END [6.7 - expose the relevant verification query]
    if result == unknown:
        if detail is None:
            try:
                detail = source.reason_unknown()
            except Exception as ex:
                detail = f"Z3 could not provide a reason: {ex}"
        record["reason_unknown"] = _nexus_safe_text(detail)
    elif result == sat and result != expected:
        if source_kind == "solver":
            try:
                model = source.model()
                assignments = {}
                for declaration in sorted(model.decls(), key=lambda d: d.name()):
                    assignments[declaration.name()] = _nexus_safe_text(model[declaration])
                record["counterexample"] = {
                    "kind": "model",
                    "assignments": assignments
                }
            except Exception as ex:
                record["counterexample_unavailable"] = _nexus_safe_text(ex)
        elif source_kind == "fixedpoint":
            try:
                answer = source.get_ground_sat_answer()
                if str(answer) == "False":
                    answer = source.get_answer()
                record["counterexample"] = {
                    "kind": "fixedpoint_answer",
                    "answer_expression": _nexus_safe_text(answer)
                }
            except Exception as ex:
                try:
                    record["counterexample"] = {
                        "kind": "fixedpoint_answer",
                        "answer_expression": _nexus_safe_text(source.get_answer())
                    }
                except Exception:
                    record["counterexample_unavailable"] = _nexus_safe_text(ex)
    VALIDATION_CHECKS.append(record)

def emit_validation_summary(loop_id, candidate_kind, components):
    values = list(components.values())
    if any(value == "invalid" for value in values):
        overall = "invalid"
    elif any(value == "unknown" for value in values):
        overall = "unknown"
    else:
        overall = "valid"
    print("VALIDATION_SUMMARY_JSON:" + json.dumps({
        "loop_id": loop_id,
        "candidate_kind": candidate_kind,
        "status": overall,
        "components": components,
        "checks": VALIDATION_CHECKS
    }, sort_keys=True, separators=(",", ":")))

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

# ============================================================
# Dependency loop: l1
# ============================================================

# Guard
l1_guard = (l1_v2 > IntVal(0))

# Entry states
fp.declare_var(Int("arg0"))
fp.declare_var(Int("arg1"))
l1_entry_states_p1 = And(BoolVal(True), (l1_v1 == Int("arg0")), (l1_v2 == Int("arg1")), (l1_v3 == l1_v3), (l1_v4 == IntVal(0)), (l1_v5 == IntVal(0)), (l1_v6 == IntVal(0)), (l1_v7 == IntVal(0)))
fp.rule(l1_entry_states(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7), l1_entry_states_p1, name="l1_entry_states_p1")

# Iteration steps
l1_iteration_steps_p1 = And((l1_v2 > IntVal(0)), l2_header_to_exit(l1_v1, (l1_v2 + IntVal(-1)), IntVal(0), l1_v4, l1_v5, l1_v6, l1_v7, l2_v1_out, l2_v2_out, l2_v3_out, l2_v4_out, l2_v5_out, l2_v6_out, l2_v7_out), (l1_v1_next == (l2_v1_out + l2_v7_out)), (l1_v2_next == (l1_v2 + IntVal(-1))), (l1_v3_next == l2_v3_out), (l1_v4_next == l2_v4_out), (l1_v5_next == l2_v5_out), (l1_v6_next == l2_v6_out), (l1_v7_next == l2_v7_out))
fp.rule(l1_iteration_steps(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v1_next, l1_v2_next, l1_v3_next, l1_v4_next, l1_v5_next, l1_v6_next, l1_v7_next), l1_iteration_steps_p1, name="l1_iteration_steps_p1")

# Exit steps
l1_exit_steps_p1 = And((l1_v2 <= IntVal(0)), (l1_v1_out == l1_v1), (l1_v2_out == (l1_v2 + IntVal(-1))), (l1_v3_out == l1_v3), (l1_v4_out == l1_v4), (l1_v5_out == l1_v5), (l1_v6_out == l1_v6), (l1_v7_out == l1_v7))
fp.rule(l1_exit_steps(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out, l1_v5_out, l1_v6_out, l1_v7_out), l1_exit_steps_p1, name="l1_exit_steps_p1")

# Return steps
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
# Dependency loop: l3
# ============================================================

# Guard
l3_guard = (l3_v3 < l3_v1)

# Entry states
l3_entry_states_p1 = And((l2_v3 < l2_v2), l2_reachable_header_states(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7), (l3_v1 == l2_v1), (l3_v2 == l2_v2), (l3_v3 == IntVal(0)), (l3_v4 == l2_v4), (l3_v5 == l2_v5), (l3_v6 == l2_v6), (l3_v7 == l2_v7))
fp.rule(l3_entry_states(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7), l3_entry_states_p1, name="l3_entry_states_p1")

# Iteration steps
l3_iteration_steps_p1 = And((l3_v3 < l3_v1), (l3_v1_next == l3_v1), (l3_v2_next == l3_v2), (l3_v3_next == (l3_v3 + IntVal(1))), (l3_v4_next == l3_v5), (l3_v5_next == (l3_v6 + IntVal(1))), (l3_v6_next == l3_v5), (l3_v7_next == l3_v7))
fp.rule(l3_iteration_steps(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v1_next, l3_v2_next, l3_v3_next, l3_v4_next, l3_v5_next, l3_v6_next, l3_v7_next), l3_iteration_steps_p1, name="l3_iteration_steps_p1")

# Exit steps
l3_exit_steps_p1 = And((l3_v3 >= l3_v1), (l3_v1_out == l3_v1), (l3_v2_out == l3_v2), (l3_v3_out == l3_v3), (l3_v4_out == l3_v4), (l3_v5_out == l3_v5), (l3_v6_out == l3_v6), (l3_v7_out == l3_v7))
fp.rule(l3_exit_steps(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v1_out, l3_v2_out, l3_v3_out, l3_v4_out, l3_v5_out, l3_v6_out, l3_v7_out), l3_exit_steps_p1, name="l3_exit_steps_p1")

# Return steps
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
# Target loop: l2
# ============================================================

# Guard
l2_guard = (l2_v3 < l2_v2)

# Entry states
l2_entry_states_p1 = And((l1_v2 > IntVal(0)), l1_reachable_header_states(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7), (l2_v1 == l1_v1), (l2_v2 == (l1_v2 + IntVal(-1))), (l2_v3 == IntVal(0)), (l2_v4 == l1_v4), (l2_v5 == l1_v5), (l2_v6 == l1_v6), (l2_v7 == l1_v7))
fp.rule(l2_entry_states(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7), l2_entry_states_p1, name="l2_entry_states_p1")

# Iteration steps
l2_iteration_steps_p1 = And((l2_v3 < l2_v2), l3_header_to_exit(l2_v1, l2_v2, IntVal(0), l2_v4, l2_v5, l2_v6, l2_v7, l3_v1_out, l3_v2_out, l3_v3_out, l3_v4_out, l3_v5_out, l3_v6_out, l3_v7_out), (l2_v1_next == l3_v5_out), (l2_v2_next == l2_v2), (l2_v3_next == (l3_v3_out + IntVal(1))), (l2_v4_next == l3_v4_out), (l2_v5_next == l3_v5_out), (l2_v6_next == l3_v6_out), (l2_v7_next == (l2_v7 + l3_v5_out)))
fp.rule(l2_iteration_steps(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next, l2_v5_next, l2_v6_next, l2_v7_next), l2_iteration_steps_p1, name="l2_iteration_steps_p1")

# Exit steps
l2_exit_steps_p1 = And((l2_v3 >= l2_v2), (l2_v1_out == l2_v1), (l2_v2_out == l2_v2), (l2_v3_out == l2_v3), (l2_v4_out == l2_v4), (l2_v5_out == l2_v5), (l2_v6_out == l2_v6), (l2_v7_out == l2_v7))
fp.rule(l2_exit_steps(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v1_out, l2_v2_out, l2_v3_out, l2_v4_out, l2_v5_out, l2_v6_out, l2_v7_out), l2_exit_steps_p1, name="l2_exit_steps_p1")

# Return steps
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
# Target candidate: l2 (non-terminating)
# ============================================================

l2_recurrent_set = And((l2_v1 <= IntVal(-1)), (l2_v6 <= IntVal(-1)))
l2_recurrent_set_next = And((l2_v1_next <= IntVal(-1)), (l2_v6_next <= IntVal(-1)))

# ============================================================
# Non-termination validation: existential recurrent-set witness
# ============================================================

l2_reachable_recurrent_set = Function("l2_reachable_recurrent_set", BoolSort())
fp.register_relation(l2_reachable_recurrent_set)
fp.rule(l2_reachable_recurrent_set(), And(l2_reachable_header_states(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7), l2_recurrent_set), name="l2_reachable_recurrent_set_rule")

# Direct, fully interpreted iteration alternatives
l2_direct_iteration_paths = []
l2_has_dependent_paths = True

def nexus_recurrent_successor(iteration_paths, recurrent_next, current_state, guard):
    if not iteration_paths:
        return BoolVal(False)
    body = And(guard, Or(*iteration_paths), recurrent_next)
    current_names = {v.decl().name() for v in current_state}
    witness_symbols = []
    found_names = set()
    pending = [body]
    while pending:
        node = pending.pop()
        if is_quantifier(node):
            pending.append(node.body())
            continue
        if is_const(node) and node.decl().kind() == Z3_OP_UNINTERPRETED and node.sort().kind() == Z3_INT_SORT:
            name = node.decl().name()
            if name not in current_names and name not in found_names:
                witness_symbols.append(node)
                found_names.add(name)
        pending.extend(node.children())
    return Exists(witness_symbols, body) if witness_symbols else body

l2_existential_progress_solver = Solver()
l2_existential_progress_solver.add(l2_recurrent_set, Not(nexus_recurrent_successor(l2_direct_iteration_paths, l2_recurrent_set_next, l2_state, l2_guard)))

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
        # >>> NEXUS CHANGE BEGIN [1.4 - Distinguish Z3 solver incompleteness from internal errors]
        recovered_result = recover_incomplete_z3_query(name, ex)
        if recovered_result is not None:
            # >>> NEXUS CHANGE BEGIN [4.3 / 6.4 - record undecidable Z3 exception]
            record_validation_check(name, recovered_result, expected, failure_message,
                                    fp, "fixedpoint", detail=str(ex), query=relation())
            # <<< NEXUS CHANGE END [4.3 / 6.4 - record undecidable Z3 exception]
            return recovered_result
        # <<< NEXUS CHANGE END [1.4 - Distinguish Z3 solver incompleteness from internal errors]
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

    # >>> NEXUS CHANGE BEGIN [4.4 / 6.5 - fixedpoint obligation result]
    record_validation_check(name, result, expected, failure_message, fp, "fixedpoint", query=relation())
    # <<< NEXUS CHANGE END [4.4 / 6.5 - fixedpoint obligation result]
    print()
    return result

def check_solver(name, solver, expected, failure_message):
    remaining = remaining_timeout_ms()
    if remaining > 0:
        solver.set(timeout=remaining)

    try:
        result = solver.check()
    except Z3Exception as ex:
        # >>> NEXUS CHANGE BEGIN [1.4 - Distinguish Z3 solver incompleteness from internal errors]
        recovered_result = recover_incomplete_z3_query(name, ex)
        if recovered_result is not None:
            # >>> NEXUS CHANGE BEGIN [4.3 / 6.4 - record undecidable Z3 exception]
            record_validation_check(name, recovered_result, expected, failure_message,
                                    solver, "solver", detail=str(ex))
            # <<< NEXUS CHANGE END [4.3 / 6.4 - record undecidable Z3 exception]
            return recovered_result
        # <<< NEXUS CHANGE END [1.4 - Distinguish Z3 solver incompleteness from internal errors]
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

    # >>> NEXUS CHANGE BEGIN [4.5 / 6.6 - solver obligation result]
    record_validation_check(name, result, expected, failure_message, solver, "solver")
    # <<< NEXUS CHANGE END [4.5 / 6.6 - solver obligation result]
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

l2_recurrent_reachability_result = check_fixedpoint(
    "RECURRENT_REACHABILITY",
    l2_reachable_recurrent_set,
    sat,
    "no reachable loop-header state belongs to the recurrent set."
)

if l2_has_dependent_paths:
    l2_recurrent_progress_result = unknown
    print('RECURRENT_EXISTENTIAL_PROGRESS: unknown')
    record_validation_check(
        'RECURRENT_EXISTENTIAL_PROGRESS', unknown, unsat,
        'iteration paths contain Horn relation calls whose semantics cannot be used directly in SMT',
        None, 'solver', detail='dependent iteration path needs a sound relational encoding')
else:
    l2_recurrent_progress_result = check_solver(
        'RECURRENT_EXISTENTIAL_PROGRESS',
        l2_existential_progress_solver,
        unsat,
        'some recurrent-set state has no completed iteration back into the set.'
    )

RECURRENT_SET_RESULT = validation_status([
    (l2_recurrent_reachability_result, sat),
    (l2_recurrent_progress_result, unsat)
])

print()
print(f'RECURRENT_SET_RESULT: "{RECURRENT_SET_RESULT}"')
emit_validation_summary("l2", "non-terminating", {"recurrent_set": RECURRENT_SET_RESULT})
