print('===================== SEMANTIC FEEDBACK =====================')
print('TARGET_LOOP: l5')
print('CANDIDATE_KIND: terminating')
print()
print('INVARIANT:')
print("{\n  \"op\": \"and\",\n  \"args\": [\n    {\n      \"op\": \">=\",\n      \"args\": [\n        \"l5_v6\",\n        0\n      ]\n    },\n    {\n      \"op\": \"<=\",\n      \"args\": [\n        \"l5_v6\",\n        \"l5_v2\"\n      ]\n    }\n  ]\n}")
print()
print('RANKING_FUNCTION:')
print("{\n  \"op\": \"-\",\n  \"args\": [\n    \"l5_v2\",\n    \"l5_v6\"\n  ]\n}")
print()
print('FEEDBACK:')
#!/usr/bin/env python3

from z3 import *
import sys
import time
import json

VALIDATION_TIMEOUT_MS = 493814
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
l1_v8 = Int("l1_v8")
fp.declare_var(l1_v8)
l1_v8_next = Int("l1_v8_next")
fp.declare_var(l1_v8_next)
l1_v8_out = Int("l1_v8_out")
fp.declare_var(l1_v8_out)
l1_v9 = Int("l1_v9")
fp.declare_var(l1_v9)
l1_v9_next = Int("l1_v9_next")
fp.declare_var(l1_v9_next)
l1_v9_out = Int("l1_v9_out")
fp.declare_var(l1_v9_out)
l1_v10 = Int("l1_v10")
fp.declare_var(l1_v10)
l1_v10_next = Int("l1_v10_next")
fp.declare_var(l1_v10_next)
l1_v10_out = Int("l1_v10_out")
fp.declare_var(l1_v10_out)
l1_v11 = Int("l1_v11")
fp.declare_var(l1_v11)
l1_v11_next = Int("l1_v11_next")
fp.declare_var(l1_v11_next)
l1_v11_out = Int("l1_v11_out")
fp.declare_var(l1_v11_out)
l1_v12 = Int("l1_v12")
fp.declare_var(l1_v12)
l1_v12_next = Int("l1_v12_next")
fp.declare_var(l1_v12_next)
l1_v12_out = Int("l1_v12_out")
fp.declare_var(l1_v12_out)
l1_v13 = Int("l1_v13")
fp.declare_var(l1_v13)
l1_v13_next = Int("l1_v13_next")
fp.declare_var(l1_v13_next)
l1_v13_out = Int("l1_v13_out")
fp.declare_var(l1_v13_out)
l1_state = [l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8, l1_v9, l1_v10, l1_v11, l1_v12, l1_v13]
l1_next_state = [l1_v1_next, l1_v2_next, l1_v3_next, l1_v4_next, l1_v5_next, l1_v6_next, l1_v7_next, l1_v8_next, l1_v9_next, l1_v10_next, l1_v11_next, l1_v12_next, l1_v13_next]
l1_output_state = [l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out, l1_v5_out, l1_v6_out, l1_v7_out, l1_v8_out, l1_v9_out, l1_v10_out, l1_v11_out, l1_v12_out, l1_v13_out]

# Nondeterministic symbols
l1_nd1 = Int("l1_nd1")
fp.declare_var(l1_nd1)
l1_nd2 = Int("l1_nd2")
fp.declare_var(l1_nd2)
l1_nd3 = Int("l1_nd3")
fp.declare_var(l1_nd3)

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
l3_v8 = Int("l3_v8")
fp.declare_var(l3_v8)
l3_v8_next = Int("l3_v8_next")
fp.declare_var(l3_v8_next)
l3_v8_out = Int("l3_v8_out")
fp.declare_var(l3_v8_out)
l3_v9 = Int("l3_v9")
fp.declare_var(l3_v9)
l3_v9_next = Int("l3_v9_next")
fp.declare_var(l3_v9_next)
l3_v9_out = Int("l3_v9_out")
fp.declare_var(l3_v9_out)
l3_v10 = Int("l3_v10")
fp.declare_var(l3_v10)
l3_v10_next = Int("l3_v10_next")
fp.declare_var(l3_v10_next)
l3_v10_out = Int("l3_v10_out")
fp.declare_var(l3_v10_out)
l3_v11 = Int("l3_v11")
fp.declare_var(l3_v11)
l3_v11_next = Int("l3_v11_next")
fp.declare_var(l3_v11_next)
l3_v11_out = Int("l3_v11_out")
fp.declare_var(l3_v11_out)
l3_v12 = Int("l3_v12")
fp.declare_var(l3_v12)
l3_v12_next = Int("l3_v12_next")
fp.declare_var(l3_v12_next)
l3_v12_out = Int("l3_v12_out")
fp.declare_var(l3_v12_out)
l3_v13 = Int("l3_v13")
fp.declare_var(l3_v13)
l3_v13_next = Int("l3_v13_next")
fp.declare_var(l3_v13_next)
l3_v13_out = Int("l3_v13_out")
fp.declare_var(l3_v13_out)
l3_state = [l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8, l3_v9, l3_v10, l3_v11, l3_v12, l3_v13]
l3_next_state = [l3_v1_next, l3_v2_next, l3_v3_next, l3_v4_next, l3_v5_next, l3_v6_next, l3_v7_next, l3_v8_next, l3_v9_next, l3_v10_next, l3_v11_next, l3_v12_next, l3_v13_next]
l3_output_state = [l3_v1_out, l3_v2_out, l3_v3_out, l3_v4_out, l3_v5_out, l3_v6_out, l3_v7_out, l3_v8_out, l3_v9_out, l3_v10_out, l3_v11_out, l3_v12_out, l3_v13_out]

# Nondeterministic symbols
l3_nd1 = Int("l3_nd1")
fp.declare_var(l3_nd1)
l3_nd2 = Int("l3_nd2")
fp.declare_var(l3_nd2)
l3_nd3 = Int("l3_nd3")
fp.declare_var(l3_nd3)
l3_nd4 = Int("l3_nd4")
fp.declare_var(l3_nd4)

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
l2_v8 = Int("l2_v8")
fp.declare_var(l2_v8)
l2_v8_next = Int("l2_v8_next")
fp.declare_var(l2_v8_next)
l2_v8_out = Int("l2_v8_out")
fp.declare_var(l2_v8_out)
l2_v9 = Int("l2_v9")
fp.declare_var(l2_v9)
l2_v9_next = Int("l2_v9_next")
fp.declare_var(l2_v9_next)
l2_v9_out = Int("l2_v9_out")
fp.declare_var(l2_v9_out)
l2_v10 = Int("l2_v10")
fp.declare_var(l2_v10)
l2_v10_next = Int("l2_v10_next")
fp.declare_var(l2_v10_next)
l2_v10_out = Int("l2_v10_out")
fp.declare_var(l2_v10_out)
l2_v11 = Int("l2_v11")
fp.declare_var(l2_v11)
l2_v11_next = Int("l2_v11_next")
fp.declare_var(l2_v11_next)
l2_v11_out = Int("l2_v11_out")
fp.declare_var(l2_v11_out)
l2_v12 = Int("l2_v12")
fp.declare_var(l2_v12)
l2_v12_next = Int("l2_v12_next")
fp.declare_var(l2_v12_next)
l2_v12_out = Int("l2_v12_out")
fp.declare_var(l2_v12_out)
l2_v13 = Int("l2_v13")
fp.declare_var(l2_v13)
l2_v13_next = Int("l2_v13_next")
fp.declare_var(l2_v13_next)
l2_v13_out = Int("l2_v13_out")
fp.declare_var(l2_v13_out)
l2_state = [l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8, l2_v9, l2_v10, l2_v11, l2_v12, l2_v13]
l2_next_state = [l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next, l2_v5_next, l2_v6_next, l2_v7_next, l2_v8_next, l2_v9_next, l2_v10_next, l2_v11_next, l2_v12_next, l2_v13_next]
l2_output_state = [l2_v1_out, l2_v2_out, l2_v3_out, l2_v4_out, l2_v5_out, l2_v6_out, l2_v7_out, l2_v8_out, l2_v9_out, l2_v10_out, l2_v11_out, l2_v12_out, l2_v13_out]

# Nondeterministic symbols
l2_nd1 = Int("l2_nd1")
fp.declare_var(l2_nd1)
l2_nd2 = Int("l2_nd2")
fp.declare_var(l2_nd2)
l2_nd3 = Int("l2_nd3")
fp.declare_var(l2_nd3)

# l7
# State symbols
l7_v1 = Int("l7_v1")
fp.declare_var(l7_v1)
l7_v1_next = Int("l7_v1_next")
fp.declare_var(l7_v1_next)
l7_v1_out = Int("l7_v1_out")
fp.declare_var(l7_v1_out)
l7_v2 = Int("l7_v2")
fp.declare_var(l7_v2)
l7_v2_next = Int("l7_v2_next")
fp.declare_var(l7_v2_next)
l7_v2_out = Int("l7_v2_out")
fp.declare_var(l7_v2_out)
l7_v3 = Int("l7_v3")
fp.declare_var(l7_v3)
l7_v3_next = Int("l7_v3_next")
fp.declare_var(l7_v3_next)
l7_v3_out = Int("l7_v3_out")
fp.declare_var(l7_v3_out)
l7_v4 = Int("l7_v4")
fp.declare_var(l7_v4)
l7_v4_next = Int("l7_v4_next")
fp.declare_var(l7_v4_next)
l7_v4_out = Int("l7_v4_out")
fp.declare_var(l7_v4_out)
l7_v5 = Int("l7_v5")
fp.declare_var(l7_v5)
l7_v5_next = Int("l7_v5_next")
fp.declare_var(l7_v5_next)
l7_v5_out = Int("l7_v5_out")
fp.declare_var(l7_v5_out)
l7_v6 = Int("l7_v6")
fp.declare_var(l7_v6)
l7_v6_next = Int("l7_v6_next")
fp.declare_var(l7_v6_next)
l7_v6_out = Int("l7_v6_out")
fp.declare_var(l7_v6_out)
l7_v7 = Int("l7_v7")
fp.declare_var(l7_v7)
l7_v7_next = Int("l7_v7_next")
fp.declare_var(l7_v7_next)
l7_v7_out = Int("l7_v7_out")
fp.declare_var(l7_v7_out)
l7_v8 = Int("l7_v8")
fp.declare_var(l7_v8)
l7_v8_next = Int("l7_v8_next")
fp.declare_var(l7_v8_next)
l7_v8_out = Int("l7_v8_out")
fp.declare_var(l7_v8_out)
l7_v9 = Int("l7_v9")
fp.declare_var(l7_v9)
l7_v9_next = Int("l7_v9_next")
fp.declare_var(l7_v9_next)
l7_v9_out = Int("l7_v9_out")
fp.declare_var(l7_v9_out)
l7_v10 = Int("l7_v10")
fp.declare_var(l7_v10)
l7_v10_next = Int("l7_v10_next")
fp.declare_var(l7_v10_next)
l7_v10_out = Int("l7_v10_out")
fp.declare_var(l7_v10_out)
l7_v11 = Int("l7_v11")
fp.declare_var(l7_v11)
l7_v11_next = Int("l7_v11_next")
fp.declare_var(l7_v11_next)
l7_v11_out = Int("l7_v11_out")
fp.declare_var(l7_v11_out)
l7_v12 = Int("l7_v12")
fp.declare_var(l7_v12)
l7_v12_next = Int("l7_v12_next")
fp.declare_var(l7_v12_next)
l7_v12_out = Int("l7_v12_out")
fp.declare_var(l7_v12_out)
l7_v13 = Int("l7_v13")
fp.declare_var(l7_v13)
l7_v13_next = Int("l7_v13_next")
fp.declare_var(l7_v13_next)
l7_v13_out = Int("l7_v13_out")
fp.declare_var(l7_v13_out)
l7_state = [l7_v1, l7_v2, l7_v3, l7_v4, l7_v5, l7_v6, l7_v7, l7_v8, l7_v9, l7_v10, l7_v11, l7_v12, l7_v13]
l7_next_state = [l7_v1_next, l7_v2_next, l7_v3_next, l7_v4_next, l7_v5_next, l7_v6_next, l7_v7_next, l7_v8_next, l7_v9_next, l7_v10_next, l7_v11_next, l7_v12_next, l7_v13_next]
l7_output_state = [l7_v1_out, l7_v2_out, l7_v3_out, l7_v4_out, l7_v5_out, l7_v6_out, l7_v7_out, l7_v8_out, l7_v9_out, l7_v10_out, l7_v11_out, l7_v12_out, l7_v13_out]

# Nondeterministic symbols
l7_nd1 = Int("l7_nd1")
fp.declare_var(l7_nd1)
l7_nd2 = Int("l7_nd2")
fp.declare_var(l7_nd2)
l7_nd3 = Int("l7_nd3")
fp.declare_var(l7_nd3)

# l6
# State symbols
l6_v1 = Int("l6_v1")
fp.declare_var(l6_v1)
l6_v1_next = Int("l6_v1_next")
fp.declare_var(l6_v1_next)
l6_v1_out = Int("l6_v1_out")
fp.declare_var(l6_v1_out)
l6_v2 = Int("l6_v2")
fp.declare_var(l6_v2)
l6_v2_next = Int("l6_v2_next")
fp.declare_var(l6_v2_next)
l6_v2_out = Int("l6_v2_out")
fp.declare_var(l6_v2_out)
l6_v3 = Int("l6_v3")
fp.declare_var(l6_v3)
l6_v3_next = Int("l6_v3_next")
fp.declare_var(l6_v3_next)
l6_v3_out = Int("l6_v3_out")
fp.declare_var(l6_v3_out)
l6_v4 = Int("l6_v4")
fp.declare_var(l6_v4)
l6_v4_next = Int("l6_v4_next")
fp.declare_var(l6_v4_next)
l6_v4_out = Int("l6_v4_out")
fp.declare_var(l6_v4_out)
l6_v5 = Int("l6_v5")
fp.declare_var(l6_v5)
l6_v5_next = Int("l6_v5_next")
fp.declare_var(l6_v5_next)
l6_v5_out = Int("l6_v5_out")
fp.declare_var(l6_v5_out)
l6_v6 = Int("l6_v6")
fp.declare_var(l6_v6)
l6_v6_next = Int("l6_v6_next")
fp.declare_var(l6_v6_next)
l6_v6_out = Int("l6_v6_out")
fp.declare_var(l6_v6_out)
l6_v7 = Int("l6_v7")
fp.declare_var(l6_v7)
l6_v7_next = Int("l6_v7_next")
fp.declare_var(l6_v7_next)
l6_v7_out = Int("l6_v7_out")
fp.declare_var(l6_v7_out)
l6_v8 = Int("l6_v8")
fp.declare_var(l6_v8)
l6_v8_next = Int("l6_v8_next")
fp.declare_var(l6_v8_next)
l6_v8_out = Int("l6_v8_out")
fp.declare_var(l6_v8_out)
l6_v9 = Int("l6_v9")
fp.declare_var(l6_v9)
l6_v9_next = Int("l6_v9_next")
fp.declare_var(l6_v9_next)
l6_v9_out = Int("l6_v9_out")
fp.declare_var(l6_v9_out)
l6_v10 = Int("l6_v10")
fp.declare_var(l6_v10)
l6_v10_next = Int("l6_v10_next")
fp.declare_var(l6_v10_next)
l6_v10_out = Int("l6_v10_out")
fp.declare_var(l6_v10_out)
l6_v11 = Int("l6_v11")
fp.declare_var(l6_v11)
l6_v11_next = Int("l6_v11_next")
fp.declare_var(l6_v11_next)
l6_v11_out = Int("l6_v11_out")
fp.declare_var(l6_v11_out)
l6_v12 = Int("l6_v12")
fp.declare_var(l6_v12)
l6_v12_next = Int("l6_v12_next")
fp.declare_var(l6_v12_next)
l6_v12_out = Int("l6_v12_out")
fp.declare_var(l6_v12_out)
l6_v13 = Int("l6_v13")
fp.declare_var(l6_v13)
l6_v13_next = Int("l6_v13_next")
fp.declare_var(l6_v13_next)
l6_v13_out = Int("l6_v13_out")
fp.declare_var(l6_v13_out)
l6_state = [l6_v1, l6_v2, l6_v3, l6_v4, l6_v5, l6_v6, l6_v7, l6_v8, l6_v9, l6_v10, l6_v11, l6_v12, l6_v13]
l6_next_state = [l6_v1_next, l6_v2_next, l6_v3_next, l6_v4_next, l6_v5_next, l6_v6_next, l6_v7_next, l6_v8_next, l6_v9_next, l6_v10_next, l6_v11_next, l6_v12_next, l6_v13_next]
l6_output_state = [l6_v1_out, l6_v2_out, l6_v3_out, l6_v4_out, l6_v5_out, l6_v6_out, l6_v7_out, l6_v8_out, l6_v9_out, l6_v10_out, l6_v11_out, l6_v12_out, l6_v13_out]

# Nondeterministic symbols
l6_nd1 = Int("l6_nd1")
fp.declare_var(l6_nd1)

# l9
# State symbols
l9_v1 = Int("l9_v1")
fp.declare_var(l9_v1)
l9_v1_next = Int("l9_v1_next")
fp.declare_var(l9_v1_next)
l9_v1_out = Int("l9_v1_out")
fp.declare_var(l9_v1_out)
l9_v2 = Int("l9_v2")
fp.declare_var(l9_v2)
l9_v2_next = Int("l9_v2_next")
fp.declare_var(l9_v2_next)
l9_v2_out = Int("l9_v2_out")
fp.declare_var(l9_v2_out)
l9_v3 = Int("l9_v3")
fp.declare_var(l9_v3)
l9_v3_next = Int("l9_v3_next")
fp.declare_var(l9_v3_next)
l9_v3_out = Int("l9_v3_out")
fp.declare_var(l9_v3_out)
l9_v4 = Int("l9_v4")
fp.declare_var(l9_v4)
l9_v4_next = Int("l9_v4_next")
fp.declare_var(l9_v4_next)
l9_v4_out = Int("l9_v4_out")
fp.declare_var(l9_v4_out)
l9_v5 = Int("l9_v5")
fp.declare_var(l9_v5)
l9_v5_next = Int("l9_v5_next")
fp.declare_var(l9_v5_next)
l9_v5_out = Int("l9_v5_out")
fp.declare_var(l9_v5_out)
l9_v6 = Int("l9_v6")
fp.declare_var(l9_v6)
l9_v6_next = Int("l9_v6_next")
fp.declare_var(l9_v6_next)
l9_v6_out = Int("l9_v6_out")
fp.declare_var(l9_v6_out)
l9_v7 = Int("l9_v7")
fp.declare_var(l9_v7)
l9_v7_next = Int("l9_v7_next")
fp.declare_var(l9_v7_next)
l9_v7_out = Int("l9_v7_out")
fp.declare_var(l9_v7_out)
l9_v8 = Int("l9_v8")
fp.declare_var(l9_v8)
l9_v8_next = Int("l9_v8_next")
fp.declare_var(l9_v8_next)
l9_v8_out = Int("l9_v8_out")
fp.declare_var(l9_v8_out)
l9_v9 = Int("l9_v9")
fp.declare_var(l9_v9)
l9_v9_next = Int("l9_v9_next")
fp.declare_var(l9_v9_next)
l9_v9_out = Int("l9_v9_out")
fp.declare_var(l9_v9_out)
l9_v10 = Int("l9_v10")
fp.declare_var(l9_v10)
l9_v10_next = Int("l9_v10_next")
fp.declare_var(l9_v10_next)
l9_v10_out = Int("l9_v10_out")
fp.declare_var(l9_v10_out)
l9_v11 = Int("l9_v11")
fp.declare_var(l9_v11)
l9_v11_next = Int("l9_v11_next")
fp.declare_var(l9_v11_next)
l9_v11_out = Int("l9_v11_out")
fp.declare_var(l9_v11_out)
l9_v12 = Int("l9_v12")
fp.declare_var(l9_v12)
l9_v12_next = Int("l9_v12_next")
fp.declare_var(l9_v12_next)
l9_v12_out = Int("l9_v12_out")
fp.declare_var(l9_v12_out)
l9_v13 = Int("l9_v13")
fp.declare_var(l9_v13)
l9_v13_next = Int("l9_v13_next")
fp.declare_var(l9_v13_next)
l9_v13_out = Int("l9_v13_out")
fp.declare_var(l9_v13_out)
l9_state = [l9_v1, l9_v2, l9_v3, l9_v4, l9_v5, l9_v6, l9_v7, l9_v8, l9_v9, l9_v10, l9_v11, l9_v12, l9_v13]
l9_next_state = [l9_v1_next, l9_v2_next, l9_v3_next, l9_v4_next, l9_v5_next, l9_v6_next, l9_v7_next, l9_v8_next, l9_v9_next, l9_v10_next, l9_v11_next, l9_v12_next, l9_v13_next]
l9_output_state = [l9_v1_out, l9_v2_out, l9_v3_out, l9_v4_out, l9_v5_out, l9_v6_out, l9_v7_out, l9_v8_out, l9_v9_out, l9_v10_out, l9_v11_out, l9_v12_out, l9_v13_out]

# Nondeterministic symbols
l9_nd1 = Int("l9_nd1")
fp.declare_var(l9_nd1)
l9_nd2 = Int("l9_nd2")
fp.declare_var(l9_nd2)
l9_nd3 = Int("l9_nd3")
fp.declare_var(l9_nd3)

# l8
# State symbols
l8_v1 = Int("l8_v1")
fp.declare_var(l8_v1)
l8_v1_next = Int("l8_v1_next")
fp.declare_var(l8_v1_next)
l8_v1_out = Int("l8_v1_out")
fp.declare_var(l8_v1_out)
l8_v2 = Int("l8_v2")
fp.declare_var(l8_v2)
l8_v2_next = Int("l8_v2_next")
fp.declare_var(l8_v2_next)
l8_v2_out = Int("l8_v2_out")
fp.declare_var(l8_v2_out)
l8_v3 = Int("l8_v3")
fp.declare_var(l8_v3)
l8_v3_next = Int("l8_v3_next")
fp.declare_var(l8_v3_next)
l8_v3_out = Int("l8_v3_out")
fp.declare_var(l8_v3_out)
l8_v4 = Int("l8_v4")
fp.declare_var(l8_v4)
l8_v4_next = Int("l8_v4_next")
fp.declare_var(l8_v4_next)
l8_v4_out = Int("l8_v4_out")
fp.declare_var(l8_v4_out)
l8_v5 = Int("l8_v5")
fp.declare_var(l8_v5)
l8_v5_next = Int("l8_v5_next")
fp.declare_var(l8_v5_next)
l8_v5_out = Int("l8_v5_out")
fp.declare_var(l8_v5_out)
l8_v6 = Int("l8_v6")
fp.declare_var(l8_v6)
l8_v6_next = Int("l8_v6_next")
fp.declare_var(l8_v6_next)
l8_v6_out = Int("l8_v6_out")
fp.declare_var(l8_v6_out)
l8_v7 = Int("l8_v7")
fp.declare_var(l8_v7)
l8_v7_next = Int("l8_v7_next")
fp.declare_var(l8_v7_next)
l8_v7_out = Int("l8_v7_out")
fp.declare_var(l8_v7_out)
l8_v8 = Int("l8_v8")
fp.declare_var(l8_v8)
l8_v8_next = Int("l8_v8_next")
fp.declare_var(l8_v8_next)
l8_v8_out = Int("l8_v8_out")
fp.declare_var(l8_v8_out)
l8_v9 = Int("l8_v9")
fp.declare_var(l8_v9)
l8_v9_next = Int("l8_v9_next")
fp.declare_var(l8_v9_next)
l8_v9_out = Int("l8_v9_out")
fp.declare_var(l8_v9_out)
l8_v10 = Int("l8_v10")
fp.declare_var(l8_v10)
l8_v10_next = Int("l8_v10_next")
fp.declare_var(l8_v10_next)
l8_v10_out = Int("l8_v10_out")
fp.declare_var(l8_v10_out)
l8_v11 = Int("l8_v11")
fp.declare_var(l8_v11)
l8_v11_next = Int("l8_v11_next")
fp.declare_var(l8_v11_next)
l8_v11_out = Int("l8_v11_out")
fp.declare_var(l8_v11_out)
l8_v12 = Int("l8_v12")
fp.declare_var(l8_v12)
l8_v12_next = Int("l8_v12_next")
fp.declare_var(l8_v12_next)
l8_v12_out = Int("l8_v12_out")
fp.declare_var(l8_v12_out)
l8_v13 = Int("l8_v13")
fp.declare_var(l8_v13)
l8_v13_next = Int("l8_v13_next")
fp.declare_var(l8_v13_next)
l8_v13_out = Int("l8_v13_out")
fp.declare_var(l8_v13_out)
l8_state = [l8_v1, l8_v2, l8_v3, l8_v4, l8_v5, l8_v6, l8_v7, l8_v8, l8_v9, l8_v10, l8_v11, l8_v12, l8_v13]
l8_next_state = [l8_v1_next, l8_v2_next, l8_v3_next, l8_v4_next, l8_v5_next, l8_v6_next, l8_v7_next, l8_v8_next, l8_v9_next, l8_v10_next, l8_v11_next, l8_v12_next, l8_v13_next]
l8_output_state = [l8_v1_out, l8_v2_out, l8_v3_out, l8_v4_out, l8_v5_out, l8_v6_out, l8_v7_out, l8_v8_out, l8_v9_out, l8_v10_out, l8_v11_out, l8_v12_out, l8_v13_out]

# l4
# State symbols
l4_v1 = Int("l4_v1")
fp.declare_var(l4_v1)
l4_v1_next = Int("l4_v1_next")
fp.declare_var(l4_v1_next)
l4_v1_out = Int("l4_v1_out")
fp.declare_var(l4_v1_out)
l4_v2 = Int("l4_v2")
fp.declare_var(l4_v2)
l4_v2_next = Int("l4_v2_next")
fp.declare_var(l4_v2_next)
l4_v2_out = Int("l4_v2_out")
fp.declare_var(l4_v2_out)
l4_v3 = Int("l4_v3")
fp.declare_var(l4_v3)
l4_v3_next = Int("l4_v3_next")
fp.declare_var(l4_v3_next)
l4_v3_out = Int("l4_v3_out")
fp.declare_var(l4_v3_out)
l4_v4 = Int("l4_v4")
fp.declare_var(l4_v4)
l4_v4_next = Int("l4_v4_next")
fp.declare_var(l4_v4_next)
l4_v4_out = Int("l4_v4_out")
fp.declare_var(l4_v4_out)
l4_v5 = Int("l4_v5")
fp.declare_var(l4_v5)
l4_v5_next = Int("l4_v5_next")
fp.declare_var(l4_v5_next)
l4_v5_out = Int("l4_v5_out")
fp.declare_var(l4_v5_out)
l4_v6 = Int("l4_v6")
fp.declare_var(l4_v6)
l4_v6_next = Int("l4_v6_next")
fp.declare_var(l4_v6_next)
l4_v6_out = Int("l4_v6_out")
fp.declare_var(l4_v6_out)
l4_v7 = Int("l4_v7")
fp.declare_var(l4_v7)
l4_v7_next = Int("l4_v7_next")
fp.declare_var(l4_v7_next)
l4_v7_out = Int("l4_v7_out")
fp.declare_var(l4_v7_out)
l4_v8 = Int("l4_v8")
fp.declare_var(l4_v8)
l4_v8_next = Int("l4_v8_next")
fp.declare_var(l4_v8_next)
l4_v8_out = Int("l4_v8_out")
fp.declare_var(l4_v8_out)
l4_v9 = Int("l4_v9")
fp.declare_var(l4_v9)
l4_v9_next = Int("l4_v9_next")
fp.declare_var(l4_v9_next)
l4_v9_out = Int("l4_v9_out")
fp.declare_var(l4_v9_out)
l4_v10 = Int("l4_v10")
fp.declare_var(l4_v10)
l4_v10_next = Int("l4_v10_next")
fp.declare_var(l4_v10_next)
l4_v10_out = Int("l4_v10_out")
fp.declare_var(l4_v10_out)
l4_v11 = Int("l4_v11")
fp.declare_var(l4_v11)
l4_v11_next = Int("l4_v11_next")
fp.declare_var(l4_v11_next)
l4_v11_out = Int("l4_v11_out")
fp.declare_var(l4_v11_out)
l4_v12 = Int("l4_v12")
fp.declare_var(l4_v12)
l4_v12_next = Int("l4_v12_next")
fp.declare_var(l4_v12_next)
l4_v12_out = Int("l4_v12_out")
fp.declare_var(l4_v12_out)
l4_v13 = Int("l4_v13")
fp.declare_var(l4_v13)
l4_v13_next = Int("l4_v13_next")
fp.declare_var(l4_v13_next)
l4_v13_out = Int("l4_v13_out")
fp.declare_var(l4_v13_out)
l4_state = [l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8, l4_v9, l4_v10, l4_v11, l4_v12, l4_v13]
l4_next_state = [l4_v1_next, l4_v2_next, l4_v3_next, l4_v4_next, l4_v5_next, l4_v6_next, l4_v7_next, l4_v8_next, l4_v9_next, l4_v10_next, l4_v11_next, l4_v12_next, l4_v13_next]
l4_output_state = [l4_v1_out, l4_v2_out, l4_v3_out, l4_v4_out, l4_v5_out, l4_v6_out, l4_v7_out, l4_v8_out, l4_v9_out, l4_v10_out, l4_v11_out, l4_v12_out, l4_v13_out]

# Nondeterministic symbols
l4_nd1 = Int("l4_nd1")
fp.declare_var(l4_nd1)
l4_nd2 = Int("l4_nd2")
fp.declare_var(l4_nd2)
l4_nd3 = Int("l4_nd3")
fp.declare_var(l4_nd3)

# l5
# State symbols
l5_v1 = Int("l5_v1")
fp.declare_var(l5_v1)
l5_v1_next = Int("l5_v1_next")
fp.declare_var(l5_v1_next)
l5_v1_out = Int("l5_v1_out")
fp.declare_var(l5_v1_out)
l5_v2 = Int("l5_v2")
fp.declare_var(l5_v2)
l5_v2_next = Int("l5_v2_next")
fp.declare_var(l5_v2_next)
l5_v2_out = Int("l5_v2_out")
fp.declare_var(l5_v2_out)
l5_v3 = Int("l5_v3")
fp.declare_var(l5_v3)
l5_v3_next = Int("l5_v3_next")
fp.declare_var(l5_v3_next)
l5_v3_out = Int("l5_v3_out")
fp.declare_var(l5_v3_out)
l5_v4 = Int("l5_v4")
fp.declare_var(l5_v4)
l5_v4_next = Int("l5_v4_next")
fp.declare_var(l5_v4_next)
l5_v4_out = Int("l5_v4_out")
fp.declare_var(l5_v4_out)
l5_v5 = Int("l5_v5")
fp.declare_var(l5_v5)
l5_v5_next = Int("l5_v5_next")
fp.declare_var(l5_v5_next)
l5_v5_out = Int("l5_v5_out")
fp.declare_var(l5_v5_out)
l5_v6 = Int("l5_v6")
fp.declare_var(l5_v6)
l5_v6_next = Int("l5_v6_next")
fp.declare_var(l5_v6_next)
l5_v6_out = Int("l5_v6_out")
fp.declare_var(l5_v6_out)
l5_v7 = Int("l5_v7")
fp.declare_var(l5_v7)
l5_v7_next = Int("l5_v7_next")
fp.declare_var(l5_v7_next)
l5_v7_out = Int("l5_v7_out")
fp.declare_var(l5_v7_out)
l5_v8 = Int("l5_v8")
fp.declare_var(l5_v8)
l5_v8_next = Int("l5_v8_next")
fp.declare_var(l5_v8_next)
l5_v8_out = Int("l5_v8_out")
fp.declare_var(l5_v8_out)
l5_v9 = Int("l5_v9")
fp.declare_var(l5_v9)
l5_v9_next = Int("l5_v9_next")
fp.declare_var(l5_v9_next)
l5_v9_out = Int("l5_v9_out")
fp.declare_var(l5_v9_out)
l5_v10 = Int("l5_v10")
fp.declare_var(l5_v10)
l5_v10_next = Int("l5_v10_next")
fp.declare_var(l5_v10_next)
l5_v10_out = Int("l5_v10_out")
fp.declare_var(l5_v10_out)
l5_v11 = Int("l5_v11")
fp.declare_var(l5_v11)
l5_v11_next = Int("l5_v11_next")
fp.declare_var(l5_v11_next)
l5_v11_out = Int("l5_v11_out")
fp.declare_var(l5_v11_out)
l5_v12 = Int("l5_v12")
fp.declare_var(l5_v12)
l5_v12_next = Int("l5_v12_next")
fp.declare_var(l5_v12_next)
l5_v12_out = Int("l5_v12_out")
fp.declare_var(l5_v12_out)
l5_v13 = Int("l5_v13")
fp.declare_var(l5_v13)
l5_v13_next = Int("l5_v13_next")
fp.declare_var(l5_v13_next)
l5_v13_out = Int("l5_v13_out")
fp.declare_var(l5_v13_out)
l5_state = [l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8, l5_v9, l5_v10, l5_v11, l5_v12, l5_v13]
l5_next_state = [l5_v1_next, l5_v2_next, l5_v3_next, l5_v4_next, l5_v5_next, l5_v6_next, l5_v7_next, l5_v8_next, l5_v9_next, l5_v10_next, l5_v11_next, l5_v12_next, l5_v13_next]
l5_output_state = [l5_v1_out, l5_v2_out, l5_v3_out, l5_v4_out, l5_v5_out, l5_v6_out, l5_v7_out, l5_v8_out, l5_v9_out, l5_v10_out, l5_v11_out, l5_v12_out, l5_v13_out]

# Nondeterministic symbols
l5_nd1 = Int("l5_nd1")
fp.declare_var(l5_nd1)
l5_nd2 = Int("l5_nd2")
fp.declare_var(l5_nd2)
l5_nd3 = Int("l5_nd3")
fp.declare_var(l5_nd3)

# ============================================================
# Relation declarations
# ============================================================

# l1
l1_entry_states = Function("l1_entry_states", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_entry_states)
l1_iteration_steps = Function("l1_iteration_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_iteration_steps)
l1_exit_steps = Function("l1_exit_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_exit_steps)
l1_return_steps = Function("l1_return_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_return_steps)
l1_reachable_header_states = Function("l1_reachable_header_states", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_reachable_header_states)
l1_header_to_exit = Function("l1_header_to_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_header_to_exit)
l1_header_to_return = Function("l1_header_to_return", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_header_to_return)
l1_actual_exit = Function("l1_actual_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_actual_exit)

# l3
l3_entry_states = Function("l3_entry_states", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l3_entry_states)
l3_iteration_steps = Function("l3_iteration_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l3_iteration_steps)
l3_exit_steps = Function("l3_exit_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l3_exit_steps)
l3_return_steps = Function("l3_return_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l3_return_steps)
l3_reachable_header_states = Function("l3_reachable_header_states", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l3_reachable_header_states)
l3_header_to_exit = Function("l3_header_to_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l3_header_to_exit)
l3_header_to_return = Function("l3_header_to_return", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l3_header_to_return)
l3_actual_exit = Function("l3_actual_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l3_actual_exit)

# l2
l2_entry_states = Function("l2_entry_states", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l2_entry_states)
l2_iteration_steps = Function("l2_iteration_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l2_iteration_steps)
l2_exit_steps = Function("l2_exit_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l2_exit_steps)
l2_return_steps = Function("l2_return_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l2_return_steps)
l2_reachable_header_states = Function("l2_reachable_header_states", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l2_reachable_header_states)
l2_header_to_exit = Function("l2_header_to_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l2_header_to_exit)
l2_header_to_return = Function("l2_header_to_return", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l2_header_to_return)
l2_actual_exit = Function("l2_actual_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l2_actual_exit)

# l7
l7_entry_states = Function("l7_entry_states", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l7_entry_states)
l7_iteration_steps = Function("l7_iteration_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l7_iteration_steps)
l7_exit_steps = Function("l7_exit_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l7_exit_steps)
l7_return_steps = Function("l7_return_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l7_return_steps)
l7_reachable_header_states = Function("l7_reachable_header_states", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l7_reachable_header_states)
l7_header_to_exit = Function("l7_header_to_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l7_header_to_exit)
l7_header_to_return = Function("l7_header_to_return", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l7_header_to_return)
l7_actual_exit = Function("l7_actual_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l7_actual_exit)

# l6
l6_entry_states = Function("l6_entry_states", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l6_entry_states)
l6_iteration_steps = Function("l6_iteration_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l6_iteration_steps)
l6_exit_steps = Function("l6_exit_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l6_exit_steps)
l6_return_steps = Function("l6_return_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l6_return_steps)
l6_reachable_header_states = Function("l6_reachable_header_states", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l6_reachable_header_states)
l6_header_to_exit = Function("l6_header_to_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l6_header_to_exit)
l6_header_to_return = Function("l6_header_to_return", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l6_header_to_return)
l6_actual_exit = Function("l6_actual_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l6_actual_exit)

# l9
l9_entry_states = Function("l9_entry_states", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l9_entry_states)
l9_iteration_steps = Function("l9_iteration_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l9_iteration_steps)
l9_exit_steps = Function("l9_exit_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l9_exit_steps)
l9_return_steps = Function("l9_return_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l9_return_steps)
l9_reachable_header_states = Function("l9_reachable_header_states", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l9_reachable_header_states)
l9_header_to_exit = Function("l9_header_to_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l9_header_to_exit)
l9_header_to_return = Function("l9_header_to_return", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l9_header_to_return)
l9_actual_exit = Function("l9_actual_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l9_actual_exit)

# l8
l8_entry_states = Function("l8_entry_states", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l8_entry_states)
l8_iteration_steps = Function("l8_iteration_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l8_iteration_steps)
l8_exit_steps = Function("l8_exit_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l8_exit_steps)
l8_return_steps = Function("l8_return_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l8_return_steps)
l8_reachable_header_states = Function("l8_reachable_header_states", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l8_reachable_header_states)
l8_header_to_exit = Function("l8_header_to_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l8_header_to_exit)
l8_header_to_return = Function("l8_header_to_return", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l8_header_to_return)
l8_actual_exit = Function("l8_actual_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l8_actual_exit)

# l4
l4_entry_states = Function("l4_entry_states", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l4_entry_states)
l4_iteration_steps = Function("l4_iteration_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l4_iteration_steps)
l4_exit_steps = Function("l4_exit_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l4_exit_steps)
l4_return_steps = Function("l4_return_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l4_return_steps)
l4_reachable_header_states = Function("l4_reachable_header_states", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l4_reachable_header_states)
l4_header_to_exit = Function("l4_header_to_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l4_header_to_exit)
l4_header_to_return = Function("l4_header_to_return", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l4_header_to_return)
l4_actual_exit = Function("l4_actual_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l4_actual_exit)

# l5
l5_entry_states = Function("l5_entry_states", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l5_entry_states)
l5_iteration_steps = Function("l5_iteration_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l5_iteration_steps)
l5_exit_steps = Function("l5_exit_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l5_exit_steps)
l5_return_steps = Function("l5_return_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l5_return_steps)
l5_reachable_header_states = Function("l5_reachable_header_states", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l5_reachable_header_states)
l5_header_to_exit = Function("l5_header_to_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l5_header_to_exit)
l5_header_to_return = Function("l5_header_to_return", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l5_header_to_return)
l5_actual_exit = Function("l5_actual_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l5_actual_exit)

# ============================================================
# Dependency loop: l1
# ============================================================

# Guard
l1_guard = (l1_v5 < l1_v1)

# Entry states
fp.declare_var(Int("arg0"))
fp.declare_var(Int("arg1"))
fp.declare_var(Int("arg2"))
l1_entry_states_p1 = And(BoolVal(True), (l1_v1 == Int("arg0")), (l1_v2 == Int("arg1")), (l1_v3 == Int("arg2")), (l1_v4 == IntVal(0)), (l1_v5 == IntVal(0)), (l1_v6 == l1_v6), (l1_v7 == l1_v7), (l1_v8 == l1_v8), (l1_v9 == l1_v9), (l1_v10 == l1_v10), (l1_v11 == l1_v11), (l1_v12 == l1_v12), (l1_v13 == IntVal(0)))
fp.rule(l1_entry_states(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8, l1_v9, l1_v10, l1_v11, l1_v12, l1_v13), l1_entry_states_p1, name="l1_entry_states_p1")

# Iteration steps
l1_iteration_steps_p1 = And(And((l1_v5 < l1_v1), (l1_nd1 == IntVal(0))), (l1_v1_next == l1_v1), (l1_v2_next == l1_v2), (l1_v3_next == l1_v3), (l1_v4_next == l1_v4), (l1_v5_next == (l1_v5 + IntVal(1))), (l1_v6_next == l1_v6), (l1_v7_next == l1_v7), (l1_v8_next == l1_v8), (l1_v9_next == l1_v9), (l1_v10_next == l1_v10), (l1_v11_next == l1_v11), (l1_v12_next == l1_v12), (l1_v13_next == l1_v13))
fp.rule(l1_iteration_steps(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8, l1_v9, l1_v10, l1_v11, l1_v12, l1_v13, l1_v1_next, l1_v2_next, l1_v3_next, l1_v4_next, l1_v5_next, l1_v6_next, l1_v7_next, l1_v8_next, l1_v9_next, l1_v10_next, l1_v11_next, l1_v12_next, l1_v13_next), l1_iteration_steps_p1, name="l1_iteration_steps_p1")

# Exit steps
l1_exit_steps_p1 = And(Or(And((l1_v5 < l1_v1), (l1_nd2 != IntVal(0))), (l1_v5 >= l1_v1)), (l1_v1_out == l1_v1), (l1_v2_out == l1_v2), (l1_v3_out == l1_v3), (l1_v4_out == l1_v4), (l1_v5_out == l1_v5), (l1_v6_out == l1_v6), (l1_v7_out == l1_v7), (l1_v8_out == l1_v8), (l1_v9_out == l1_v9), (l1_v10_out == l1_v10), (l1_v11_out == l1_v11), (l1_v12_out == l1_v12), (l1_v13_out == l1_v13))
fp.rule(l1_exit_steps(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8, l1_v9, l1_v10, l1_v11, l1_v12, l1_v13, l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out, l1_v5_out, l1_v6_out, l1_v7_out, l1_v8_out, l1_v9_out, l1_v10_out, l1_v11_out, l1_v12_out, l1_v13_out), l1_exit_steps_p1, name="l1_exit_steps_p1")

# Return steps
# Reachable header states
l1_reachable_header_states_base = l1_entry_states(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8, l1_v9, l1_v10, l1_v11, l1_v12, l1_v13)
fp.rule(l1_reachable_header_states(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8, l1_v9, l1_v10, l1_v11, l1_v12, l1_v13), l1_reachable_header_states_base, name="l1_reachable_header_states_base")

l1_reachable_header_states_recursive = And(l1_reachable_header_states(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8, l1_v9, l1_v10, l1_v11, l1_v12, l1_v13), l1_iteration_steps(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8, l1_v9, l1_v10, l1_v11, l1_v12, l1_v13, l1_v1_next, l1_v2_next, l1_v3_next, l1_v4_next, l1_v5_next, l1_v6_next, l1_v7_next, l1_v8_next, l1_v9_next, l1_v10_next, l1_v11_next, l1_v12_next, l1_v13_next))
fp.rule(l1_reachable_header_states(l1_v1_next, l1_v2_next, l1_v3_next, l1_v4_next, l1_v5_next, l1_v6_next, l1_v7_next, l1_v8_next, l1_v9_next, l1_v10_next, l1_v11_next, l1_v12_next, l1_v13_next), l1_reachable_header_states_recursive, name="l1_reachable_header_states_recursive")

# Header to exit
l1_header_to_exit_base = l1_exit_steps(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8, l1_v9, l1_v10, l1_v11, l1_v12, l1_v13, l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out, l1_v5_out, l1_v6_out, l1_v7_out, l1_v8_out, l1_v9_out, l1_v10_out, l1_v11_out, l1_v12_out, l1_v13_out)
fp.rule(l1_header_to_exit(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8, l1_v9, l1_v10, l1_v11, l1_v12, l1_v13, l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out, l1_v5_out, l1_v6_out, l1_v7_out, l1_v8_out, l1_v9_out, l1_v10_out, l1_v11_out, l1_v12_out, l1_v13_out), l1_header_to_exit_base, name="l1_header_to_exit_base")

l1_header_to_exit_recursive = And(l1_iteration_steps(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8, l1_v9, l1_v10, l1_v11, l1_v12, l1_v13, l1_v1_next, l1_v2_next, l1_v3_next, l1_v4_next, l1_v5_next, l1_v6_next, l1_v7_next, l1_v8_next, l1_v9_next, l1_v10_next, l1_v11_next, l1_v12_next, l1_v13_next), l1_header_to_exit(l1_v1_next, l1_v2_next, l1_v3_next, l1_v4_next, l1_v5_next, l1_v6_next, l1_v7_next, l1_v8_next, l1_v9_next, l1_v10_next, l1_v11_next, l1_v12_next, l1_v13_next, l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out, l1_v5_out, l1_v6_out, l1_v7_out, l1_v8_out, l1_v9_out, l1_v10_out, l1_v11_out, l1_v12_out, l1_v13_out))
fp.rule(l1_header_to_exit(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8, l1_v9, l1_v10, l1_v11, l1_v12, l1_v13, l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out, l1_v5_out, l1_v6_out, l1_v7_out, l1_v8_out, l1_v9_out, l1_v10_out, l1_v11_out, l1_v12_out, l1_v13_out), l1_header_to_exit_recursive, name="l1_header_to_exit_recursive")

# Header to return
l1_header_to_return_base = l1_return_steps(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8, l1_v9, l1_v10, l1_v11, l1_v12, l1_v13)
fp.rule(l1_header_to_return(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8, l1_v9, l1_v10, l1_v11, l1_v12, l1_v13), l1_header_to_return_base, name="l1_header_to_return_base")

l1_header_to_return_recursive = And(l1_iteration_steps(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8, l1_v9, l1_v10, l1_v11, l1_v12, l1_v13, l1_v1_next, l1_v2_next, l1_v3_next, l1_v4_next, l1_v5_next, l1_v6_next, l1_v7_next, l1_v8_next, l1_v9_next, l1_v10_next, l1_v11_next, l1_v12_next, l1_v13_next), l1_header_to_return(l1_v1_next, l1_v2_next, l1_v3_next, l1_v4_next, l1_v5_next, l1_v6_next, l1_v7_next, l1_v8_next, l1_v9_next, l1_v10_next, l1_v11_next, l1_v12_next, l1_v13_next))
fp.rule(l1_header_to_return(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8, l1_v9, l1_v10, l1_v11, l1_v12, l1_v13), l1_header_to_return_recursive, name="l1_header_to_return_recursive")

# Actual exit
l1_actual_exit_rule = And(l1_entry_states(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8, l1_v9, l1_v10, l1_v11, l1_v12, l1_v13), l1_header_to_exit(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8, l1_v9, l1_v10, l1_v11, l1_v12, l1_v13, l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out, l1_v5_out, l1_v6_out, l1_v7_out, l1_v8_out, l1_v9_out, l1_v10_out, l1_v11_out, l1_v12_out, l1_v13_out))
fp.rule(l1_actual_exit(l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out, l1_v5_out, l1_v6_out, l1_v7_out, l1_v8_out, l1_v9_out, l1_v10_out, l1_v11_out, l1_v12_out, l1_v13_out), l1_actual_exit_rule, name="l1_actual_exit_rule")

# ============================================================
# Dependency loop: l3
# ============================================================

# Guard
l3_guard = (l3_v8 < l3_v13)

# Entry states
l3_entry_states_p1 = And(And((l2_v7 < l2_v2), (l3_nd1 != IntVal(0))), l2_reachable_header_states(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8, l2_v9, l2_v10, l2_v11, l2_v12, l2_v13), (l3_v1 == l2_v1), (l3_v2 == l2_v2), (l3_v3 == l2_v3), (l3_v4 == l2_v4), (l3_v5 == l2_v5), (l3_v6 == l2_v6), (l3_v7 == l2_v7), (l3_v8 == IntVal(0)), (l3_v9 == l2_v9), (l3_v10 == l2_v10), (l3_v11 == l2_v11), (l3_v12 == l2_v12), (l3_v13 == l2_v13))
fp.rule(l3_entry_states(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8, l3_v9, l3_v10, l3_v11, l3_v12, l3_v13), l3_entry_states_p1, name="l3_entry_states_p1")

# Iteration steps
l3_iteration_steps_p1 = And(And((l3_v8 < l3_v13), (l3_nd2 == IntVal(0))), (l3_v1_next == l3_v1), (l3_v2_next == l3_v2), (l3_v3_next == l3_v3), (l3_v4_next == l3_v4), (l3_v5_next == l3_v5), (l3_v6_next == l3_v6), (l3_v7_next == l3_v7), (l3_v8_next == (l3_v8 + IntVal(1))), (l3_v9_next == l3_v9), (l3_v10_next == l3_v10), (l3_v11_next == l3_v11), (l3_v12_next == l3_v12), (l3_v13_next == l3_v13))
fp.rule(l3_iteration_steps(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8, l3_v9, l3_v10, l3_v11, l3_v12, l3_v13, l3_v1_next, l3_v2_next, l3_v3_next, l3_v4_next, l3_v5_next, l3_v6_next, l3_v7_next, l3_v8_next, l3_v9_next, l3_v10_next, l3_v11_next, l3_v12_next, l3_v13_next), l3_iteration_steps_p1, name="l3_iteration_steps_p1")

# Exit steps
l3_exit_steps_p1 = And(Or(And((l3_v8 < l3_v13), (l3_nd3 != IntVal(0))), (l3_v8 >= l3_v13)), (l3_v1_out == l3_v1), (l3_v2_out == l3_v2), (l3_v3_out == l3_v3), (l3_v4_out == l3_v4), (l3_v5_out == l3_v5), (l3_v6_out == l3_v6), (l3_v7_out == l3_v7), (l3_v8_out == l3_v8), (l3_v9_out == l3_v9), (l3_v10_out == l3_v10), (l3_v11_out == l3_v11), (l3_v12_out == l3_v12), (l3_v13_out == l3_v13))
fp.rule(l3_exit_steps(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8, l3_v9, l3_v10, l3_v11, l3_v12, l3_v13, l3_v1_out, l3_v2_out, l3_v3_out, l3_v4_out, l3_v5_out, l3_v6_out, l3_v7_out, l3_v8_out, l3_v9_out, l3_v10_out, l3_v11_out, l3_v12_out, l3_v13_out), l3_exit_steps_p1, name="l3_exit_steps_p1")

# Return steps
# Reachable header states
l3_reachable_header_states_base = l3_entry_states(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8, l3_v9, l3_v10, l3_v11, l3_v12, l3_v13)
fp.rule(l3_reachable_header_states(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8, l3_v9, l3_v10, l3_v11, l3_v12, l3_v13), l3_reachable_header_states_base, name="l3_reachable_header_states_base")

l3_reachable_header_states_recursive = And(l3_reachable_header_states(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8, l3_v9, l3_v10, l3_v11, l3_v12, l3_v13), l3_iteration_steps(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8, l3_v9, l3_v10, l3_v11, l3_v12, l3_v13, l3_v1_next, l3_v2_next, l3_v3_next, l3_v4_next, l3_v5_next, l3_v6_next, l3_v7_next, l3_v8_next, l3_v9_next, l3_v10_next, l3_v11_next, l3_v12_next, l3_v13_next))
fp.rule(l3_reachable_header_states(l3_v1_next, l3_v2_next, l3_v3_next, l3_v4_next, l3_v5_next, l3_v6_next, l3_v7_next, l3_v8_next, l3_v9_next, l3_v10_next, l3_v11_next, l3_v12_next, l3_v13_next), l3_reachable_header_states_recursive, name="l3_reachable_header_states_recursive")

# Header to exit
l3_header_to_exit_base = l3_exit_steps(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8, l3_v9, l3_v10, l3_v11, l3_v12, l3_v13, l3_v1_out, l3_v2_out, l3_v3_out, l3_v4_out, l3_v5_out, l3_v6_out, l3_v7_out, l3_v8_out, l3_v9_out, l3_v10_out, l3_v11_out, l3_v12_out, l3_v13_out)
fp.rule(l3_header_to_exit(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8, l3_v9, l3_v10, l3_v11, l3_v12, l3_v13, l3_v1_out, l3_v2_out, l3_v3_out, l3_v4_out, l3_v5_out, l3_v6_out, l3_v7_out, l3_v8_out, l3_v9_out, l3_v10_out, l3_v11_out, l3_v12_out, l3_v13_out), l3_header_to_exit_base, name="l3_header_to_exit_base")

l3_header_to_exit_recursive = And(l3_iteration_steps(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8, l3_v9, l3_v10, l3_v11, l3_v12, l3_v13, l3_v1_next, l3_v2_next, l3_v3_next, l3_v4_next, l3_v5_next, l3_v6_next, l3_v7_next, l3_v8_next, l3_v9_next, l3_v10_next, l3_v11_next, l3_v12_next, l3_v13_next), l3_header_to_exit(l3_v1_next, l3_v2_next, l3_v3_next, l3_v4_next, l3_v5_next, l3_v6_next, l3_v7_next, l3_v8_next, l3_v9_next, l3_v10_next, l3_v11_next, l3_v12_next, l3_v13_next, l3_v1_out, l3_v2_out, l3_v3_out, l3_v4_out, l3_v5_out, l3_v6_out, l3_v7_out, l3_v8_out, l3_v9_out, l3_v10_out, l3_v11_out, l3_v12_out, l3_v13_out))
fp.rule(l3_header_to_exit(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8, l3_v9, l3_v10, l3_v11, l3_v12, l3_v13, l3_v1_out, l3_v2_out, l3_v3_out, l3_v4_out, l3_v5_out, l3_v6_out, l3_v7_out, l3_v8_out, l3_v9_out, l3_v10_out, l3_v11_out, l3_v12_out, l3_v13_out), l3_header_to_exit_recursive, name="l3_header_to_exit_recursive")

# Header to return
l3_header_to_return_base = l3_return_steps(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8, l3_v9, l3_v10, l3_v11, l3_v12, l3_v13)
fp.rule(l3_header_to_return(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8, l3_v9, l3_v10, l3_v11, l3_v12, l3_v13), l3_header_to_return_base, name="l3_header_to_return_base")

l3_header_to_return_recursive = And(l3_iteration_steps(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8, l3_v9, l3_v10, l3_v11, l3_v12, l3_v13, l3_v1_next, l3_v2_next, l3_v3_next, l3_v4_next, l3_v5_next, l3_v6_next, l3_v7_next, l3_v8_next, l3_v9_next, l3_v10_next, l3_v11_next, l3_v12_next, l3_v13_next), l3_header_to_return(l3_v1_next, l3_v2_next, l3_v3_next, l3_v4_next, l3_v5_next, l3_v6_next, l3_v7_next, l3_v8_next, l3_v9_next, l3_v10_next, l3_v11_next, l3_v12_next, l3_v13_next))
fp.rule(l3_header_to_return(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8, l3_v9, l3_v10, l3_v11, l3_v12, l3_v13), l3_header_to_return_recursive, name="l3_header_to_return_recursive")

# Actual exit
l3_actual_exit_rule = And(l3_entry_states(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8, l3_v9, l3_v10, l3_v11, l3_v12, l3_v13), l3_header_to_exit(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8, l3_v9, l3_v10, l3_v11, l3_v12, l3_v13, l3_v1_out, l3_v2_out, l3_v3_out, l3_v4_out, l3_v5_out, l3_v6_out, l3_v7_out, l3_v8_out, l3_v9_out, l3_v10_out, l3_v11_out, l3_v12_out, l3_v13_out))
fp.rule(l3_actual_exit(l3_v1_out, l3_v2_out, l3_v3_out, l3_v4_out, l3_v5_out, l3_v6_out, l3_v7_out, l3_v8_out, l3_v9_out, l3_v10_out, l3_v11_out, l3_v12_out, l3_v13_out), l3_actual_exit_rule, name="l3_actual_exit_rule")

# ============================================================
# Dependency loop: l2
# ============================================================

# Guard
l2_guard = (l2_v7 < l2_v2)

# Entry states
l2_entry_states_p1 = And((l1_v5_out < l1_v1_out), l1_actual_exit(l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out, l1_v5_out, l1_v6_out, l1_v7_out, l1_v8_out, l1_v9_out, l1_v10_out, l1_v11_out, l1_v12_out, l1_v13_out), (l2_v1 == l1_v1_out), (l2_v2 == l1_v2_out), (l2_v3 == l1_v3_out), (l2_v4 == l1_v4_out), (l2_v5 == l1_v5_out), (l2_v6 == l1_v6_out), (l2_v7 == IntVal(0)), (l2_v8 == l1_v8_out), (l2_v9 == l1_v9_out), (l2_v10 == l1_v10_out), (l2_v11 == l1_v11_out), (l2_v12 == l1_v12_out), (l2_v13 == l1_v13_out))
fp.rule(l2_entry_states(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8, l2_v9, l2_v10, l2_v11, l2_v12, l2_v13), l2_entry_states_p1, name="l2_entry_states_p1")

# Iteration steps
l2_iteration_steps_p1 = And(And((l2_v7 < l2_v2), (l2_nd1 != IntVal(0)), (l3_v8_out == l2_v13)), l3_header_to_exit(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, IntVal(0), l2_v9, l2_v10, l2_v11, l2_v12, l2_v13, l3_v1_out, l3_v2_out, l3_v3_out, l3_v4_out, l3_v5_out, l3_v6_out, l3_v7_out, l3_v8_out, l3_v9_out, l3_v10_out, l3_v11_out, l3_v12_out, l3_v13_out), (l2_v1_next == l2_v1), (l2_v2_next == l2_v2), (l2_v3_next == l2_v3), (l2_v4_next == l2_v4), (l2_v5_next == l2_v5), (l2_v6_next == l2_v6), (l2_v7_next == (l2_v7 + IntVal(1))), (l2_v8_next == l3_v8_out), (l2_v9_next == l2_v9), (l2_v10_next == l2_v10), (l2_v11_next == l2_v11), (l2_v12_next == l2_v12), (l2_v13_next == (l2_v13 + IntVal(1))))
fp.rule(l2_iteration_steps(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8, l2_v9, l2_v10, l2_v11, l2_v12, l2_v13, l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next, l2_v5_next, l2_v6_next, l2_v7_next, l2_v8_next, l2_v9_next, l2_v10_next, l2_v11_next, l2_v12_next, l2_v13_next), l2_iteration_steps_p1, name="l2_iteration_steps_p1")

l2_iteration_steps_p2 = And(And((l2_v7 < l2_v2), (l2_nd1 != IntVal(0)), (l3_v8_out != l2_v13)), l3_header_to_exit(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, IntVal(0), l2_v9, l2_v10, l2_v11, l2_v12, l2_v13, l3_v1_out, l3_v2_out, l3_v3_out, l3_v4_out, l3_v5_out, l3_v6_out, l3_v7_out, l3_v8_out, l3_v9_out, l3_v10_out, l3_v11_out, l3_v12_out, l3_v13_out), (l2_v1_next == l2_v1), (l2_v2_next == l2_v2), (l2_v3_next == l2_v3), (l2_v4_next == l2_v4), (l2_v5_next == l2_v5), (l2_v6_next == l2_v6), (l2_v7_next == (l2_v7 + IntVal(1))), (l2_v8_next == l3_v8_out), (l2_v9_next == l2_v9), (l2_v10_next == l2_v10), (l2_v11_next == l2_v11), (l2_v12_next == l2_v12), (l2_v13_next == l2_v13))
fp.rule(l2_iteration_steps(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8, l2_v9, l2_v10, l2_v11, l2_v12, l2_v13, l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next, l2_v5_next, l2_v6_next, l2_v7_next, l2_v8_next, l2_v9_next, l2_v10_next, l2_v11_next, l2_v12_next, l2_v13_next), l2_iteration_steps_p2, name="l2_iteration_steps_p2")

l2_iteration_steps_p3 = And(And((l2_v7 < l2_v2), (l2_nd1 == IntVal(0))), (l2_v1_next == l2_v1), (l2_v2_next == l2_v2), (l2_v3_next == l2_v3), (l2_v4_next == l2_v4), (l2_v5_next == l2_v5), (l2_v6_next == l2_v6), (l2_v7_next == (l2_v7 + IntVal(1))), (l2_v8_next == l2_v8), (l2_v9_next == l2_v9), (l2_v10_next == l2_v10), (l2_v11_next == l2_v11), (l2_v12_next == l2_v12), (l2_v13_next == l2_v13))
fp.rule(l2_iteration_steps(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8, l2_v9, l2_v10, l2_v11, l2_v12, l2_v13, l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next, l2_v5_next, l2_v6_next, l2_v7_next, l2_v8_next, l2_v9_next, l2_v10_next, l2_v11_next, l2_v12_next, l2_v13_next), l2_iteration_steps_p3, name="l2_iteration_steps_p3")

# Exit steps
l2_exit_steps_p1 = And((l2_v7 >= l2_v2), (l2_v1_out == l2_v1), (l2_v2_out == l2_v2), (l2_v3_out == l2_v3), (l2_v4_out == l2_v4), (l2_v5_out == l2_v5), (l2_v6_out == l2_v6), (l2_v7_out == l2_v7), (l2_v8_out == l2_v8), (l2_v9_out == l2_v9), (l2_v10_out == l2_v10), (l2_v11_out == l2_v11), (l2_v12_out == l2_v12), (l2_v13_out == l2_v13))
fp.rule(l2_exit_steps(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8, l2_v9, l2_v10, l2_v11, l2_v12, l2_v13, l2_v1_out, l2_v2_out, l2_v3_out, l2_v4_out, l2_v5_out, l2_v6_out, l2_v7_out, l2_v8_out, l2_v9_out, l2_v10_out, l2_v11_out, l2_v12_out, l2_v13_out), l2_exit_steps_p1, name="l2_exit_steps_p1")

# Return steps
# Reachable header states
l2_reachable_header_states_base = l2_entry_states(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8, l2_v9, l2_v10, l2_v11, l2_v12, l2_v13)
fp.rule(l2_reachable_header_states(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8, l2_v9, l2_v10, l2_v11, l2_v12, l2_v13), l2_reachable_header_states_base, name="l2_reachable_header_states_base")

l2_reachable_header_states_recursive = And(l2_reachable_header_states(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8, l2_v9, l2_v10, l2_v11, l2_v12, l2_v13), l2_iteration_steps(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8, l2_v9, l2_v10, l2_v11, l2_v12, l2_v13, l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next, l2_v5_next, l2_v6_next, l2_v7_next, l2_v8_next, l2_v9_next, l2_v10_next, l2_v11_next, l2_v12_next, l2_v13_next))
fp.rule(l2_reachable_header_states(l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next, l2_v5_next, l2_v6_next, l2_v7_next, l2_v8_next, l2_v9_next, l2_v10_next, l2_v11_next, l2_v12_next, l2_v13_next), l2_reachable_header_states_recursive, name="l2_reachable_header_states_recursive")

# Header to exit
l2_header_to_exit_base = l2_exit_steps(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8, l2_v9, l2_v10, l2_v11, l2_v12, l2_v13, l2_v1_out, l2_v2_out, l2_v3_out, l2_v4_out, l2_v5_out, l2_v6_out, l2_v7_out, l2_v8_out, l2_v9_out, l2_v10_out, l2_v11_out, l2_v12_out, l2_v13_out)
fp.rule(l2_header_to_exit(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8, l2_v9, l2_v10, l2_v11, l2_v12, l2_v13, l2_v1_out, l2_v2_out, l2_v3_out, l2_v4_out, l2_v5_out, l2_v6_out, l2_v7_out, l2_v8_out, l2_v9_out, l2_v10_out, l2_v11_out, l2_v12_out, l2_v13_out), l2_header_to_exit_base, name="l2_header_to_exit_base")

l2_header_to_exit_recursive = And(l2_iteration_steps(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8, l2_v9, l2_v10, l2_v11, l2_v12, l2_v13, l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next, l2_v5_next, l2_v6_next, l2_v7_next, l2_v8_next, l2_v9_next, l2_v10_next, l2_v11_next, l2_v12_next, l2_v13_next), l2_header_to_exit(l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next, l2_v5_next, l2_v6_next, l2_v7_next, l2_v8_next, l2_v9_next, l2_v10_next, l2_v11_next, l2_v12_next, l2_v13_next, l2_v1_out, l2_v2_out, l2_v3_out, l2_v4_out, l2_v5_out, l2_v6_out, l2_v7_out, l2_v8_out, l2_v9_out, l2_v10_out, l2_v11_out, l2_v12_out, l2_v13_out))
fp.rule(l2_header_to_exit(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8, l2_v9, l2_v10, l2_v11, l2_v12, l2_v13, l2_v1_out, l2_v2_out, l2_v3_out, l2_v4_out, l2_v5_out, l2_v6_out, l2_v7_out, l2_v8_out, l2_v9_out, l2_v10_out, l2_v11_out, l2_v12_out, l2_v13_out), l2_header_to_exit_recursive, name="l2_header_to_exit_recursive")

# Header to return
l2_header_to_return_base = l2_return_steps(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8, l2_v9, l2_v10, l2_v11, l2_v12, l2_v13)
fp.rule(l2_header_to_return(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8, l2_v9, l2_v10, l2_v11, l2_v12, l2_v13), l2_header_to_return_base, name="l2_header_to_return_base")

l2_header_to_return_recursive = And(l2_iteration_steps(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8, l2_v9, l2_v10, l2_v11, l2_v12, l2_v13, l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next, l2_v5_next, l2_v6_next, l2_v7_next, l2_v8_next, l2_v9_next, l2_v10_next, l2_v11_next, l2_v12_next, l2_v13_next), l2_header_to_return(l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next, l2_v5_next, l2_v6_next, l2_v7_next, l2_v8_next, l2_v9_next, l2_v10_next, l2_v11_next, l2_v12_next, l2_v13_next))
fp.rule(l2_header_to_return(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8, l2_v9, l2_v10, l2_v11, l2_v12, l2_v13), l2_header_to_return_recursive, name="l2_header_to_return_recursive")

# Actual exit
l2_actual_exit_rule = And(l2_entry_states(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8, l2_v9, l2_v10, l2_v11, l2_v12, l2_v13), l2_header_to_exit(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8, l2_v9, l2_v10, l2_v11, l2_v12, l2_v13, l2_v1_out, l2_v2_out, l2_v3_out, l2_v4_out, l2_v5_out, l2_v6_out, l2_v7_out, l2_v8_out, l2_v9_out, l2_v10_out, l2_v11_out, l2_v12_out, l2_v13_out))
fp.rule(l2_actual_exit(l2_v1_out, l2_v2_out, l2_v3_out, l2_v4_out, l2_v5_out, l2_v6_out, l2_v7_out, l2_v8_out, l2_v9_out, l2_v10_out, l2_v11_out, l2_v12_out, l2_v13_out), l2_actual_exit_rule, name="l2_actual_exit_rule")

# ============================================================
# Dependency loop: l7
# ============================================================

# Guard
l7_guard = (l7_v8 < l7_v12)

# Entry states
l7_entry_states_p1 = And((l6_v7 < l6_v10), l6_reachable_header_states(l6_v1, l6_v2, l6_v3, l6_v4, l6_v5, l6_v6, l6_v7, l6_v8, l6_v9, l6_v10, l6_v11, l6_v12, l6_v13), (l7_v1 == l6_v1), (l7_v2 == l6_v2), (l7_v3 == l6_v3), (l7_v4 == l6_v4), (l7_v5 == l6_v5), (l7_v6 == l6_v6), (l7_v7 == l6_v7), (l7_v8 == IntVal(0)), (l7_v9 == l6_v9), (l7_v10 == l6_v10), (l7_v11 == l6_v11), (l7_v12 == l6_v12), (l7_v13 == l6_v13))
fp.rule(l7_entry_states(l7_v1, l7_v2, l7_v3, l7_v4, l7_v5, l7_v6, l7_v7, l7_v8, l7_v9, l7_v10, l7_v11, l7_v12, l7_v13), l7_entry_states_p1, name="l7_entry_states_p1")

# Iteration steps
l7_iteration_steps_p1 = And(And((l7_v8 < l7_v12), (l7_nd1 == IntVal(0))), (l7_v1_next == l7_v1), (l7_v2_next == l7_v2), (l7_v3_next == l7_v3), (l7_v4_next == l7_v4), (l7_v5_next == l7_v5), (l7_v6_next == l7_v6), (l7_v7_next == l7_v7), (l7_v8_next == (l7_v8 + IntVal(1))), (l7_v9_next == l7_v9), (l7_v10_next == l7_v10), (l7_v11_next == l7_v11), (l7_v12_next == l7_v12), (l7_v13_next == l7_v13))
fp.rule(l7_iteration_steps(l7_v1, l7_v2, l7_v3, l7_v4, l7_v5, l7_v6, l7_v7, l7_v8, l7_v9, l7_v10, l7_v11, l7_v12, l7_v13, l7_v1_next, l7_v2_next, l7_v3_next, l7_v4_next, l7_v5_next, l7_v6_next, l7_v7_next, l7_v8_next, l7_v9_next, l7_v10_next, l7_v11_next, l7_v12_next, l7_v13_next), l7_iteration_steps_p1, name="l7_iteration_steps_p1")

# Exit steps
l7_exit_steps_p1 = And(Or(And((l7_v8 < l7_v12), (l7_nd2 != IntVal(0))), (l7_v8 >= l7_v12)), (l7_v1_out == l7_v1), (l7_v2_out == l7_v2), (l7_v3_out == l7_v3), (l7_v4_out == l7_v4), (l7_v5_out == l7_v5), (l7_v6_out == l7_v6), (l7_v7_out == l7_v7), (l7_v8_out == l7_v8), (l7_v9_out == l7_v9), (l7_v10_out == l7_v10), (l7_v11_out == l7_v11), (l7_v12_out == l7_v12), (l7_v13_out == l7_v13))
fp.rule(l7_exit_steps(l7_v1, l7_v2, l7_v3, l7_v4, l7_v5, l7_v6, l7_v7, l7_v8, l7_v9, l7_v10, l7_v11, l7_v12, l7_v13, l7_v1_out, l7_v2_out, l7_v3_out, l7_v4_out, l7_v5_out, l7_v6_out, l7_v7_out, l7_v8_out, l7_v9_out, l7_v10_out, l7_v11_out, l7_v12_out, l7_v13_out), l7_exit_steps_p1, name="l7_exit_steps_p1")

# Return steps
# Reachable header states
l7_reachable_header_states_base = l7_entry_states(l7_v1, l7_v2, l7_v3, l7_v4, l7_v5, l7_v6, l7_v7, l7_v8, l7_v9, l7_v10, l7_v11, l7_v12, l7_v13)
fp.rule(l7_reachable_header_states(l7_v1, l7_v2, l7_v3, l7_v4, l7_v5, l7_v6, l7_v7, l7_v8, l7_v9, l7_v10, l7_v11, l7_v12, l7_v13), l7_reachable_header_states_base, name="l7_reachable_header_states_base")

l7_reachable_header_states_recursive = And(l7_reachable_header_states(l7_v1, l7_v2, l7_v3, l7_v4, l7_v5, l7_v6, l7_v7, l7_v8, l7_v9, l7_v10, l7_v11, l7_v12, l7_v13), l7_iteration_steps(l7_v1, l7_v2, l7_v3, l7_v4, l7_v5, l7_v6, l7_v7, l7_v8, l7_v9, l7_v10, l7_v11, l7_v12, l7_v13, l7_v1_next, l7_v2_next, l7_v3_next, l7_v4_next, l7_v5_next, l7_v6_next, l7_v7_next, l7_v8_next, l7_v9_next, l7_v10_next, l7_v11_next, l7_v12_next, l7_v13_next))
fp.rule(l7_reachable_header_states(l7_v1_next, l7_v2_next, l7_v3_next, l7_v4_next, l7_v5_next, l7_v6_next, l7_v7_next, l7_v8_next, l7_v9_next, l7_v10_next, l7_v11_next, l7_v12_next, l7_v13_next), l7_reachable_header_states_recursive, name="l7_reachable_header_states_recursive")

# Header to exit
l7_header_to_exit_base = l7_exit_steps(l7_v1, l7_v2, l7_v3, l7_v4, l7_v5, l7_v6, l7_v7, l7_v8, l7_v9, l7_v10, l7_v11, l7_v12, l7_v13, l7_v1_out, l7_v2_out, l7_v3_out, l7_v4_out, l7_v5_out, l7_v6_out, l7_v7_out, l7_v8_out, l7_v9_out, l7_v10_out, l7_v11_out, l7_v12_out, l7_v13_out)
fp.rule(l7_header_to_exit(l7_v1, l7_v2, l7_v3, l7_v4, l7_v5, l7_v6, l7_v7, l7_v8, l7_v9, l7_v10, l7_v11, l7_v12, l7_v13, l7_v1_out, l7_v2_out, l7_v3_out, l7_v4_out, l7_v5_out, l7_v6_out, l7_v7_out, l7_v8_out, l7_v9_out, l7_v10_out, l7_v11_out, l7_v12_out, l7_v13_out), l7_header_to_exit_base, name="l7_header_to_exit_base")

l7_header_to_exit_recursive = And(l7_iteration_steps(l7_v1, l7_v2, l7_v3, l7_v4, l7_v5, l7_v6, l7_v7, l7_v8, l7_v9, l7_v10, l7_v11, l7_v12, l7_v13, l7_v1_next, l7_v2_next, l7_v3_next, l7_v4_next, l7_v5_next, l7_v6_next, l7_v7_next, l7_v8_next, l7_v9_next, l7_v10_next, l7_v11_next, l7_v12_next, l7_v13_next), l7_header_to_exit(l7_v1_next, l7_v2_next, l7_v3_next, l7_v4_next, l7_v5_next, l7_v6_next, l7_v7_next, l7_v8_next, l7_v9_next, l7_v10_next, l7_v11_next, l7_v12_next, l7_v13_next, l7_v1_out, l7_v2_out, l7_v3_out, l7_v4_out, l7_v5_out, l7_v6_out, l7_v7_out, l7_v8_out, l7_v9_out, l7_v10_out, l7_v11_out, l7_v12_out, l7_v13_out))
fp.rule(l7_header_to_exit(l7_v1, l7_v2, l7_v3, l7_v4, l7_v5, l7_v6, l7_v7, l7_v8, l7_v9, l7_v10, l7_v11, l7_v12, l7_v13, l7_v1_out, l7_v2_out, l7_v3_out, l7_v4_out, l7_v5_out, l7_v6_out, l7_v7_out, l7_v8_out, l7_v9_out, l7_v10_out, l7_v11_out, l7_v12_out, l7_v13_out), l7_header_to_exit_recursive, name="l7_header_to_exit_recursive")

# Header to return
l7_header_to_return_base = l7_return_steps(l7_v1, l7_v2, l7_v3, l7_v4, l7_v5, l7_v6, l7_v7, l7_v8, l7_v9, l7_v10, l7_v11, l7_v12, l7_v13)
fp.rule(l7_header_to_return(l7_v1, l7_v2, l7_v3, l7_v4, l7_v5, l7_v6, l7_v7, l7_v8, l7_v9, l7_v10, l7_v11, l7_v12, l7_v13), l7_header_to_return_base, name="l7_header_to_return_base")

l7_header_to_return_recursive = And(l7_iteration_steps(l7_v1, l7_v2, l7_v3, l7_v4, l7_v5, l7_v6, l7_v7, l7_v8, l7_v9, l7_v10, l7_v11, l7_v12, l7_v13, l7_v1_next, l7_v2_next, l7_v3_next, l7_v4_next, l7_v5_next, l7_v6_next, l7_v7_next, l7_v8_next, l7_v9_next, l7_v10_next, l7_v11_next, l7_v12_next, l7_v13_next), l7_header_to_return(l7_v1_next, l7_v2_next, l7_v3_next, l7_v4_next, l7_v5_next, l7_v6_next, l7_v7_next, l7_v8_next, l7_v9_next, l7_v10_next, l7_v11_next, l7_v12_next, l7_v13_next))
fp.rule(l7_header_to_return(l7_v1, l7_v2, l7_v3, l7_v4, l7_v5, l7_v6, l7_v7, l7_v8, l7_v9, l7_v10, l7_v11, l7_v12, l7_v13), l7_header_to_return_recursive, name="l7_header_to_return_recursive")

# Actual exit
l7_actual_exit_rule = And(l7_entry_states(l7_v1, l7_v2, l7_v3, l7_v4, l7_v5, l7_v6, l7_v7, l7_v8, l7_v9, l7_v10, l7_v11, l7_v12, l7_v13), l7_header_to_exit(l7_v1, l7_v2, l7_v3, l7_v4, l7_v5, l7_v6, l7_v7, l7_v8, l7_v9, l7_v10, l7_v11, l7_v12, l7_v13, l7_v1_out, l7_v2_out, l7_v3_out, l7_v4_out, l7_v5_out, l7_v6_out, l7_v7_out, l7_v8_out, l7_v9_out, l7_v10_out, l7_v11_out, l7_v12_out, l7_v13_out))
fp.rule(l7_actual_exit(l7_v1_out, l7_v2_out, l7_v3_out, l7_v4_out, l7_v5_out, l7_v6_out, l7_v7_out, l7_v8_out, l7_v9_out, l7_v10_out, l7_v11_out, l7_v12_out, l7_v13_out), l7_actual_exit_rule, name="l7_actual_exit_rule")

# ============================================================
# Dependency loop: l6
# ============================================================

# Guard
l6_guard = (l6_v7 < l6_v10)

# Entry states
l6_entry_states_p1 = And(And((l5_v3_out != IntVal(0)), (l6_nd1 != IntVal(0))), l5_actual_exit(l5_v1_out, l5_v2_out, l5_v3_out, l5_v4_out, l5_v5_out, l5_v6_out, l5_v7_out, l5_v8_out, l5_v9_out, l5_v10_out, l5_v11_out, l5_v12_out, l5_v13_out), (l6_v1 == l5_v1_out), (l6_v2 == l5_v2_out), (l6_v3 == l5_v3_out), (l6_v4 == l5_v4_out), (l6_v5 == l5_v5_out), (l6_v6 == l5_v6_out), (l6_v7 == IntVal(0)), (l6_v8 == l5_v8_out), (l6_v9 == l5_v9_out), (l6_v10 == l5_v10_out), (l6_v11 == l5_v11_out), (l6_v12 == IntVal(0)), (l6_v13 == l5_v13_out))
fp.rule(l6_entry_states(l6_v1, l6_v2, l6_v3, l6_v4, l6_v5, l6_v6, l6_v7, l6_v8, l6_v9, l6_v10, l6_v11, l6_v12, l6_v13), l6_entry_states_p1, name="l6_entry_states_p1")

# Iteration steps
l6_iteration_steps_p1 = And(And((l6_v7 < l6_v10), (l7_v8_out == l6_v12)), l7_header_to_exit(l6_v1, l6_v2, l6_v3, l6_v4, l6_v5, l6_v6, l6_v7, IntVal(0), l6_v9, l6_v10, l6_v11, l6_v12, l6_v13, l7_v1_out, l7_v2_out, l7_v3_out, l7_v4_out, l7_v5_out, l7_v6_out, l7_v7_out, l7_v8_out, l7_v9_out, l7_v10_out, l7_v11_out, l7_v12_out, l7_v13_out), (l6_v1_next == l6_v1), (l6_v2_next == l6_v2), (l6_v3_next == l6_v3), (l6_v4_next == l6_v4), (l6_v5_next == l6_v5), (l6_v6_next == l6_v6), (l6_v7_next == (l6_v7 + IntVal(1))), (l6_v8_next == l7_v8_out), (l6_v9_next == l6_v9), (l6_v10_next == l6_v10), (l6_v11_next == l6_v11), (l6_v12_next == (l6_v12 + IntVal(1))), (l6_v13_next == l6_v13))
fp.rule(l6_iteration_steps(l6_v1, l6_v2, l6_v3, l6_v4, l6_v5, l6_v6, l6_v7, l6_v8, l6_v9, l6_v10, l6_v11, l6_v12, l6_v13, l6_v1_next, l6_v2_next, l6_v3_next, l6_v4_next, l6_v5_next, l6_v6_next, l6_v7_next, l6_v8_next, l6_v9_next, l6_v10_next, l6_v11_next, l6_v12_next, l6_v13_next), l6_iteration_steps_p1, name="l6_iteration_steps_p1")

l6_iteration_steps_p2 = And(And((l6_v7 < l6_v10), (l7_v8_out != l6_v12)), l7_header_to_exit(l6_v1, l6_v2, l6_v3, l6_v4, l6_v5, l6_v6, l6_v7, IntVal(0), l6_v9, l6_v10, l6_v11, l6_v12, l6_v13, l7_v1_out, l7_v2_out, l7_v3_out, l7_v4_out, l7_v5_out, l7_v6_out, l7_v7_out, l7_v8_out, l7_v9_out, l7_v10_out, l7_v11_out, l7_v12_out, l7_v13_out), (l6_v1_next == l6_v1), (l6_v2_next == l6_v2), (l6_v3_next == l6_v3), (l6_v4_next == l6_v4), (l6_v5_next == l6_v5), (l6_v6_next == l6_v6), (l6_v7_next == (l6_v7 + IntVal(1))), (l6_v8_next == l7_v8_out), (l6_v9_next == l6_v9), (l6_v10_next == l6_v10), (l6_v11_next == l6_v11), (l6_v12_next == l6_v12), (l6_v13_next == l6_v13))
fp.rule(l6_iteration_steps(l6_v1, l6_v2, l6_v3, l6_v4, l6_v5, l6_v6, l6_v7, l6_v8, l6_v9, l6_v10, l6_v11, l6_v12, l6_v13, l6_v1_next, l6_v2_next, l6_v3_next, l6_v4_next, l6_v5_next, l6_v6_next, l6_v7_next, l6_v8_next, l6_v9_next, l6_v10_next, l6_v11_next, l6_v12_next, l6_v13_next), l6_iteration_steps_p2, name="l6_iteration_steps_p2")

# Exit steps
l6_exit_steps_p1 = And((l6_v7 >= l6_v10), (l6_v1_out == l6_v1), (l6_v2_out == l6_v2), (l6_v3_out == l6_v3), (l6_v4_out == l6_v4), (l6_v5_out == l6_v5), (l6_v6_out == l6_v6), (l6_v7_out == l6_v7), (l6_v8_out == l6_v8), (l6_v9_out == l6_v9), (l6_v10_out == l6_v10), (l6_v11_out == l6_v11), (l6_v12_out == l6_v12), (l6_v13_out == l6_v13))
fp.rule(l6_exit_steps(l6_v1, l6_v2, l6_v3, l6_v4, l6_v5, l6_v6, l6_v7, l6_v8, l6_v9, l6_v10, l6_v11, l6_v12, l6_v13, l6_v1_out, l6_v2_out, l6_v3_out, l6_v4_out, l6_v5_out, l6_v6_out, l6_v7_out, l6_v8_out, l6_v9_out, l6_v10_out, l6_v11_out, l6_v12_out, l6_v13_out), l6_exit_steps_p1, name="l6_exit_steps_p1")

# Return steps
# Reachable header states
l6_reachable_header_states_base = l6_entry_states(l6_v1, l6_v2, l6_v3, l6_v4, l6_v5, l6_v6, l6_v7, l6_v8, l6_v9, l6_v10, l6_v11, l6_v12, l6_v13)
fp.rule(l6_reachable_header_states(l6_v1, l6_v2, l6_v3, l6_v4, l6_v5, l6_v6, l6_v7, l6_v8, l6_v9, l6_v10, l6_v11, l6_v12, l6_v13), l6_reachable_header_states_base, name="l6_reachable_header_states_base")

l6_reachable_header_states_recursive = And(l6_reachable_header_states(l6_v1, l6_v2, l6_v3, l6_v4, l6_v5, l6_v6, l6_v7, l6_v8, l6_v9, l6_v10, l6_v11, l6_v12, l6_v13), l6_iteration_steps(l6_v1, l6_v2, l6_v3, l6_v4, l6_v5, l6_v6, l6_v7, l6_v8, l6_v9, l6_v10, l6_v11, l6_v12, l6_v13, l6_v1_next, l6_v2_next, l6_v3_next, l6_v4_next, l6_v5_next, l6_v6_next, l6_v7_next, l6_v8_next, l6_v9_next, l6_v10_next, l6_v11_next, l6_v12_next, l6_v13_next))
fp.rule(l6_reachable_header_states(l6_v1_next, l6_v2_next, l6_v3_next, l6_v4_next, l6_v5_next, l6_v6_next, l6_v7_next, l6_v8_next, l6_v9_next, l6_v10_next, l6_v11_next, l6_v12_next, l6_v13_next), l6_reachable_header_states_recursive, name="l6_reachable_header_states_recursive")

# Header to exit
l6_header_to_exit_base = l6_exit_steps(l6_v1, l6_v2, l6_v3, l6_v4, l6_v5, l6_v6, l6_v7, l6_v8, l6_v9, l6_v10, l6_v11, l6_v12, l6_v13, l6_v1_out, l6_v2_out, l6_v3_out, l6_v4_out, l6_v5_out, l6_v6_out, l6_v7_out, l6_v8_out, l6_v9_out, l6_v10_out, l6_v11_out, l6_v12_out, l6_v13_out)
fp.rule(l6_header_to_exit(l6_v1, l6_v2, l6_v3, l6_v4, l6_v5, l6_v6, l6_v7, l6_v8, l6_v9, l6_v10, l6_v11, l6_v12, l6_v13, l6_v1_out, l6_v2_out, l6_v3_out, l6_v4_out, l6_v5_out, l6_v6_out, l6_v7_out, l6_v8_out, l6_v9_out, l6_v10_out, l6_v11_out, l6_v12_out, l6_v13_out), l6_header_to_exit_base, name="l6_header_to_exit_base")

l6_header_to_exit_recursive = And(l6_iteration_steps(l6_v1, l6_v2, l6_v3, l6_v4, l6_v5, l6_v6, l6_v7, l6_v8, l6_v9, l6_v10, l6_v11, l6_v12, l6_v13, l6_v1_next, l6_v2_next, l6_v3_next, l6_v4_next, l6_v5_next, l6_v6_next, l6_v7_next, l6_v8_next, l6_v9_next, l6_v10_next, l6_v11_next, l6_v12_next, l6_v13_next), l6_header_to_exit(l6_v1_next, l6_v2_next, l6_v3_next, l6_v4_next, l6_v5_next, l6_v6_next, l6_v7_next, l6_v8_next, l6_v9_next, l6_v10_next, l6_v11_next, l6_v12_next, l6_v13_next, l6_v1_out, l6_v2_out, l6_v3_out, l6_v4_out, l6_v5_out, l6_v6_out, l6_v7_out, l6_v8_out, l6_v9_out, l6_v10_out, l6_v11_out, l6_v12_out, l6_v13_out))
fp.rule(l6_header_to_exit(l6_v1, l6_v2, l6_v3, l6_v4, l6_v5, l6_v6, l6_v7, l6_v8, l6_v9, l6_v10, l6_v11, l6_v12, l6_v13, l6_v1_out, l6_v2_out, l6_v3_out, l6_v4_out, l6_v5_out, l6_v6_out, l6_v7_out, l6_v8_out, l6_v9_out, l6_v10_out, l6_v11_out, l6_v12_out, l6_v13_out), l6_header_to_exit_recursive, name="l6_header_to_exit_recursive")

# Header to return
l6_header_to_return_base = l6_return_steps(l6_v1, l6_v2, l6_v3, l6_v4, l6_v5, l6_v6, l6_v7, l6_v8, l6_v9, l6_v10, l6_v11, l6_v12, l6_v13)
fp.rule(l6_header_to_return(l6_v1, l6_v2, l6_v3, l6_v4, l6_v5, l6_v6, l6_v7, l6_v8, l6_v9, l6_v10, l6_v11, l6_v12, l6_v13), l6_header_to_return_base, name="l6_header_to_return_base")

l6_header_to_return_recursive = And(l6_iteration_steps(l6_v1, l6_v2, l6_v3, l6_v4, l6_v5, l6_v6, l6_v7, l6_v8, l6_v9, l6_v10, l6_v11, l6_v12, l6_v13, l6_v1_next, l6_v2_next, l6_v3_next, l6_v4_next, l6_v5_next, l6_v6_next, l6_v7_next, l6_v8_next, l6_v9_next, l6_v10_next, l6_v11_next, l6_v12_next, l6_v13_next), l6_header_to_return(l6_v1_next, l6_v2_next, l6_v3_next, l6_v4_next, l6_v5_next, l6_v6_next, l6_v7_next, l6_v8_next, l6_v9_next, l6_v10_next, l6_v11_next, l6_v12_next, l6_v13_next))
fp.rule(l6_header_to_return(l6_v1, l6_v2, l6_v3, l6_v4, l6_v5, l6_v6, l6_v7, l6_v8, l6_v9, l6_v10, l6_v11, l6_v12, l6_v13), l6_header_to_return_recursive, name="l6_header_to_return_recursive")

# Actual exit
l6_actual_exit_rule = And(l6_entry_states(l6_v1, l6_v2, l6_v3, l6_v4, l6_v5, l6_v6, l6_v7, l6_v8, l6_v9, l6_v10, l6_v11, l6_v12, l6_v13), l6_header_to_exit(l6_v1, l6_v2, l6_v3, l6_v4, l6_v5, l6_v6, l6_v7, l6_v8, l6_v9, l6_v10, l6_v11, l6_v12, l6_v13, l6_v1_out, l6_v2_out, l6_v3_out, l6_v4_out, l6_v5_out, l6_v6_out, l6_v7_out, l6_v8_out, l6_v9_out, l6_v10_out, l6_v11_out, l6_v12_out, l6_v13_out))
fp.rule(l6_actual_exit(l6_v1_out, l6_v2_out, l6_v3_out, l6_v4_out, l6_v5_out, l6_v6_out, l6_v7_out, l6_v8_out, l6_v9_out, l6_v10_out, l6_v11_out, l6_v12_out, l6_v13_out), l6_actual_exit_rule, name="l6_actual_exit_rule")

# ============================================================
# Dependency loop: l9
# ============================================================

# Guard
l9_guard = (l9_v7 < l9_v10)

# Entry states
l9_entry_states_p1 = And((l8_v8 < l8_v12), l8_reachable_header_states(l8_v1, l8_v2, l8_v3, l8_v4, l8_v5, l8_v6, l8_v7, l8_v8, l8_v9, l8_v10, l8_v11, l8_v12, l8_v13), (l9_v1 == l8_v1), (l9_v2 == l8_v2), (l9_v3 == l8_v3), (l9_v4 == l8_v4), (l9_v5 == l8_v5), (l9_v6 == l8_v6), (l9_v7 == IntVal(0)), (l9_v8 == l8_v8), (l9_v9 == l8_v9), (l9_v10 == l8_v10), (l9_v11 == IntVal(0)), (l9_v12 == l8_v12), (l9_v13 == l8_v13))
fp.rule(l9_entry_states(l9_v1, l9_v2, l9_v3, l9_v4, l9_v5, l9_v6, l9_v7, l9_v8, l9_v9, l9_v10, l9_v11, l9_v12, l9_v13), l9_entry_states_p1, name="l9_entry_states_p1")

# Iteration steps
l9_iteration_steps_p1 = And(And((l9_v7 < l9_v10), (l9_nd1 != IntVal(0))), (l9_v1_next == l9_v1), (l9_v2_next == l9_v2), (l9_v3_next == l9_v3), (l9_v4_next == l9_v4), (l9_v5_next == l9_v5), (l9_v6_next == l9_v6), (l9_v7_next == (l9_v7 + IntVal(1))), (l9_v8_next == l9_v8), (l9_v9_next == l9_v9), (l9_v10_next == l9_v10), (l9_v11_next == (l9_v11 + IntVal(1))), (l9_v12_next == l9_v12), (l9_v13_next == l9_v13))
fp.rule(l9_iteration_steps(l9_v1, l9_v2, l9_v3, l9_v4, l9_v5, l9_v6, l9_v7, l9_v8, l9_v9, l9_v10, l9_v11, l9_v12, l9_v13, l9_v1_next, l9_v2_next, l9_v3_next, l9_v4_next, l9_v5_next, l9_v6_next, l9_v7_next, l9_v8_next, l9_v9_next, l9_v10_next, l9_v11_next, l9_v12_next, l9_v13_next), l9_iteration_steps_p1, name="l9_iteration_steps_p1")

l9_iteration_steps_p2 = And(And((l9_v7 < l9_v10), (l9_nd1 == IntVal(0))), (l9_v1_next == l9_v1), (l9_v2_next == l9_v2), (l9_v3_next == l9_v3), (l9_v4_next == l9_v4), (l9_v5_next == l9_v5), (l9_v6_next == l9_v6), (l9_v7_next == (l9_v7 + IntVal(1))), (l9_v8_next == l9_v8), (l9_v9_next == l9_v9), (l9_v10_next == l9_v10), (l9_v11_next == l9_v11), (l9_v12_next == l9_v12), (l9_v13_next == l9_v13))
fp.rule(l9_iteration_steps(l9_v1, l9_v2, l9_v3, l9_v4, l9_v5, l9_v6, l9_v7, l9_v8, l9_v9, l9_v10, l9_v11, l9_v12, l9_v13, l9_v1_next, l9_v2_next, l9_v3_next, l9_v4_next, l9_v5_next, l9_v6_next, l9_v7_next, l9_v8_next, l9_v9_next, l9_v10_next, l9_v11_next, l9_v12_next, l9_v13_next), l9_iteration_steps_p2, name="l9_iteration_steps_p2")

# Exit steps
l9_exit_steps_p1 = And((l9_v7 >= l9_v10), (l9_v1_out == l9_v1), (l9_v2_out == l9_v2), (l9_v3_out == l9_v3), (l9_v4_out == l9_v4), (l9_v5_out == l9_v5), (l9_v6_out == l9_v6), (l9_v7_out == l9_v7), (l9_v8_out == l9_v8), (l9_v9_out == l9_v9), (l9_v10_out == l9_v10), (l9_v11_out == l9_v11), (l9_v12_out == l9_v12), (l9_v13_out == l9_v13))
fp.rule(l9_exit_steps(l9_v1, l9_v2, l9_v3, l9_v4, l9_v5, l9_v6, l9_v7, l9_v8, l9_v9, l9_v10, l9_v11, l9_v12, l9_v13, l9_v1_out, l9_v2_out, l9_v3_out, l9_v4_out, l9_v5_out, l9_v6_out, l9_v7_out, l9_v8_out, l9_v9_out, l9_v10_out, l9_v11_out, l9_v12_out, l9_v13_out), l9_exit_steps_p1, name="l9_exit_steps_p1")

# Return steps
# Reachable header states
l9_reachable_header_states_base = l9_entry_states(l9_v1, l9_v2, l9_v3, l9_v4, l9_v5, l9_v6, l9_v7, l9_v8, l9_v9, l9_v10, l9_v11, l9_v12, l9_v13)
fp.rule(l9_reachable_header_states(l9_v1, l9_v2, l9_v3, l9_v4, l9_v5, l9_v6, l9_v7, l9_v8, l9_v9, l9_v10, l9_v11, l9_v12, l9_v13), l9_reachable_header_states_base, name="l9_reachable_header_states_base")

l9_reachable_header_states_recursive = And(l9_reachable_header_states(l9_v1, l9_v2, l9_v3, l9_v4, l9_v5, l9_v6, l9_v7, l9_v8, l9_v9, l9_v10, l9_v11, l9_v12, l9_v13), l9_iteration_steps(l9_v1, l9_v2, l9_v3, l9_v4, l9_v5, l9_v6, l9_v7, l9_v8, l9_v9, l9_v10, l9_v11, l9_v12, l9_v13, l9_v1_next, l9_v2_next, l9_v3_next, l9_v4_next, l9_v5_next, l9_v6_next, l9_v7_next, l9_v8_next, l9_v9_next, l9_v10_next, l9_v11_next, l9_v12_next, l9_v13_next))
fp.rule(l9_reachable_header_states(l9_v1_next, l9_v2_next, l9_v3_next, l9_v4_next, l9_v5_next, l9_v6_next, l9_v7_next, l9_v8_next, l9_v9_next, l9_v10_next, l9_v11_next, l9_v12_next, l9_v13_next), l9_reachable_header_states_recursive, name="l9_reachable_header_states_recursive")

# Header to exit
l9_header_to_exit_base = l9_exit_steps(l9_v1, l9_v2, l9_v3, l9_v4, l9_v5, l9_v6, l9_v7, l9_v8, l9_v9, l9_v10, l9_v11, l9_v12, l9_v13, l9_v1_out, l9_v2_out, l9_v3_out, l9_v4_out, l9_v5_out, l9_v6_out, l9_v7_out, l9_v8_out, l9_v9_out, l9_v10_out, l9_v11_out, l9_v12_out, l9_v13_out)
fp.rule(l9_header_to_exit(l9_v1, l9_v2, l9_v3, l9_v4, l9_v5, l9_v6, l9_v7, l9_v8, l9_v9, l9_v10, l9_v11, l9_v12, l9_v13, l9_v1_out, l9_v2_out, l9_v3_out, l9_v4_out, l9_v5_out, l9_v6_out, l9_v7_out, l9_v8_out, l9_v9_out, l9_v10_out, l9_v11_out, l9_v12_out, l9_v13_out), l9_header_to_exit_base, name="l9_header_to_exit_base")

l9_header_to_exit_recursive = And(l9_iteration_steps(l9_v1, l9_v2, l9_v3, l9_v4, l9_v5, l9_v6, l9_v7, l9_v8, l9_v9, l9_v10, l9_v11, l9_v12, l9_v13, l9_v1_next, l9_v2_next, l9_v3_next, l9_v4_next, l9_v5_next, l9_v6_next, l9_v7_next, l9_v8_next, l9_v9_next, l9_v10_next, l9_v11_next, l9_v12_next, l9_v13_next), l9_header_to_exit(l9_v1_next, l9_v2_next, l9_v3_next, l9_v4_next, l9_v5_next, l9_v6_next, l9_v7_next, l9_v8_next, l9_v9_next, l9_v10_next, l9_v11_next, l9_v12_next, l9_v13_next, l9_v1_out, l9_v2_out, l9_v3_out, l9_v4_out, l9_v5_out, l9_v6_out, l9_v7_out, l9_v8_out, l9_v9_out, l9_v10_out, l9_v11_out, l9_v12_out, l9_v13_out))
fp.rule(l9_header_to_exit(l9_v1, l9_v2, l9_v3, l9_v4, l9_v5, l9_v6, l9_v7, l9_v8, l9_v9, l9_v10, l9_v11, l9_v12, l9_v13, l9_v1_out, l9_v2_out, l9_v3_out, l9_v4_out, l9_v5_out, l9_v6_out, l9_v7_out, l9_v8_out, l9_v9_out, l9_v10_out, l9_v11_out, l9_v12_out, l9_v13_out), l9_header_to_exit_recursive, name="l9_header_to_exit_recursive")

# Header to return
l9_header_to_return_base = l9_return_steps(l9_v1, l9_v2, l9_v3, l9_v4, l9_v5, l9_v6, l9_v7, l9_v8, l9_v9, l9_v10, l9_v11, l9_v12, l9_v13)
fp.rule(l9_header_to_return(l9_v1, l9_v2, l9_v3, l9_v4, l9_v5, l9_v6, l9_v7, l9_v8, l9_v9, l9_v10, l9_v11, l9_v12, l9_v13), l9_header_to_return_base, name="l9_header_to_return_base")

l9_header_to_return_recursive = And(l9_iteration_steps(l9_v1, l9_v2, l9_v3, l9_v4, l9_v5, l9_v6, l9_v7, l9_v8, l9_v9, l9_v10, l9_v11, l9_v12, l9_v13, l9_v1_next, l9_v2_next, l9_v3_next, l9_v4_next, l9_v5_next, l9_v6_next, l9_v7_next, l9_v8_next, l9_v9_next, l9_v10_next, l9_v11_next, l9_v12_next, l9_v13_next), l9_header_to_return(l9_v1_next, l9_v2_next, l9_v3_next, l9_v4_next, l9_v5_next, l9_v6_next, l9_v7_next, l9_v8_next, l9_v9_next, l9_v10_next, l9_v11_next, l9_v12_next, l9_v13_next))
fp.rule(l9_header_to_return(l9_v1, l9_v2, l9_v3, l9_v4, l9_v5, l9_v6, l9_v7, l9_v8, l9_v9, l9_v10, l9_v11, l9_v12, l9_v13), l9_header_to_return_recursive, name="l9_header_to_return_recursive")

# Actual exit
l9_actual_exit_rule = And(l9_entry_states(l9_v1, l9_v2, l9_v3, l9_v4, l9_v5, l9_v6, l9_v7, l9_v8, l9_v9, l9_v10, l9_v11, l9_v12, l9_v13), l9_header_to_exit(l9_v1, l9_v2, l9_v3, l9_v4, l9_v5, l9_v6, l9_v7, l9_v8, l9_v9, l9_v10, l9_v11, l9_v12, l9_v13, l9_v1_out, l9_v2_out, l9_v3_out, l9_v4_out, l9_v5_out, l9_v6_out, l9_v7_out, l9_v8_out, l9_v9_out, l9_v10_out, l9_v11_out, l9_v12_out, l9_v13_out))
fp.rule(l9_actual_exit(l9_v1_out, l9_v2_out, l9_v3_out, l9_v4_out, l9_v5_out, l9_v6_out, l9_v7_out, l9_v8_out, l9_v9_out, l9_v10_out, l9_v11_out, l9_v12_out, l9_v13_out), l9_actual_exit_rule, name="l9_actual_exit_rule")

# ============================================================
# Dependency loop: l8
# ============================================================

# Guard
l8_guard = (l8_v8 < l8_v12)

# Entry states
l8_entry_states_p1 = And((l6_v12_out > IntVal(1)), l6_actual_exit(l6_v1_out, l6_v2_out, l6_v3_out, l6_v4_out, l6_v5_out, l6_v6_out, l6_v7_out, l6_v8_out, l6_v9_out, l6_v10_out, l6_v11_out, l6_v12_out, l6_v13_out), (l8_v1 == l6_v1_out), (l8_v2 == l6_v2_out), (l8_v3 == l6_v3_out), (l8_v4 == l6_v4_out), (l8_v5 == l6_v5_out), (l8_v6 == l6_v6_out), (l8_v7 == l6_v7_out), (l8_v8 == IntVal(0)), (l8_v9 == l6_v9_out), (l8_v10 == l6_v10_out), (l8_v11 == l6_v11_out), (l8_v12 == l6_v12_out), (l8_v13 == l6_v13_out))
fp.rule(l8_entry_states(l8_v1, l8_v2, l8_v3, l8_v4, l8_v5, l8_v6, l8_v7, l8_v8, l8_v9, l8_v10, l8_v11, l8_v12, l8_v13), l8_entry_states_p1, name="l8_entry_states_p1")

# Iteration steps
l8_iteration_steps_p1 = And((l8_v8 < l8_v12), l9_header_to_exit(l8_v1, l8_v2, l8_v3, l8_v4, l8_v5, l8_v6, IntVal(0), l8_v8, l8_v9, l8_v10, IntVal(0), l8_v12, l8_v13, l9_v1_out, l9_v2_out, l9_v3_out, l9_v4_out, l9_v5_out, l9_v6_out, l9_v7_out, l9_v8_out, l9_v9_out, l9_v10_out, l9_v11_out, l9_v12_out, l9_v13_out), (l8_v1_next == l8_v1), (l8_v2_next == l8_v2), (l8_v3_next == l8_v3), (l8_v4_next == l8_v4), (l8_v5_next == l8_v5), (l8_v6_next == l8_v6), (l8_v7_next == l9_v7_out), (l8_v8_next == (l8_v8 + IntVal(1))), (l8_v9_next == l8_v9), (l8_v10_next == l8_v10), (l8_v11_next == l9_v11_out), (l8_v12_next == l8_v12), (l8_v13_next == l8_v13))
fp.rule(l8_iteration_steps(l8_v1, l8_v2, l8_v3, l8_v4, l8_v5, l8_v6, l8_v7, l8_v8, l8_v9, l8_v10, l8_v11, l8_v12, l8_v13, l8_v1_next, l8_v2_next, l8_v3_next, l8_v4_next, l8_v5_next, l8_v6_next, l8_v7_next, l8_v8_next, l8_v9_next, l8_v10_next, l8_v11_next, l8_v12_next, l8_v13_next), l8_iteration_steps_p1, name="l8_iteration_steps_p1")

# Exit steps
l8_exit_steps_p1 = And((l8_v8 >= l8_v12), (l8_v1_out == l8_v1), (l8_v2_out == l8_v2), (l8_v3_out == l8_v3), (l8_v4_out == l8_v4), (l8_v5_out == l8_v5), (l8_v6_out == l8_v6), (l8_v7_out == l8_v7), (l8_v8_out == l8_v8), (l8_v9_out == l8_v9), (l8_v10_out == l8_v10), (l8_v11_out == l8_v11), (l8_v12_out == l8_v12), (l8_v13_out == l8_v13))
fp.rule(l8_exit_steps(l8_v1, l8_v2, l8_v3, l8_v4, l8_v5, l8_v6, l8_v7, l8_v8, l8_v9, l8_v10, l8_v11, l8_v12, l8_v13, l8_v1_out, l8_v2_out, l8_v3_out, l8_v4_out, l8_v5_out, l8_v6_out, l8_v7_out, l8_v8_out, l8_v9_out, l8_v10_out, l8_v11_out, l8_v12_out, l8_v13_out), l8_exit_steps_p1, name="l8_exit_steps_p1")

# Return steps
# Reachable header states
l8_reachable_header_states_base = l8_entry_states(l8_v1, l8_v2, l8_v3, l8_v4, l8_v5, l8_v6, l8_v7, l8_v8, l8_v9, l8_v10, l8_v11, l8_v12, l8_v13)
fp.rule(l8_reachable_header_states(l8_v1, l8_v2, l8_v3, l8_v4, l8_v5, l8_v6, l8_v7, l8_v8, l8_v9, l8_v10, l8_v11, l8_v12, l8_v13), l8_reachable_header_states_base, name="l8_reachable_header_states_base")

l8_reachable_header_states_recursive = And(l8_reachable_header_states(l8_v1, l8_v2, l8_v3, l8_v4, l8_v5, l8_v6, l8_v7, l8_v8, l8_v9, l8_v10, l8_v11, l8_v12, l8_v13), l8_iteration_steps(l8_v1, l8_v2, l8_v3, l8_v4, l8_v5, l8_v6, l8_v7, l8_v8, l8_v9, l8_v10, l8_v11, l8_v12, l8_v13, l8_v1_next, l8_v2_next, l8_v3_next, l8_v4_next, l8_v5_next, l8_v6_next, l8_v7_next, l8_v8_next, l8_v9_next, l8_v10_next, l8_v11_next, l8_v12_next, l8_v13_next))
fp.rule(l8_reachable_header_states(l8_v1_next, l8_v2_next, l8_v3_next, l8_v4_next, l8_v5_next, l8_v6_next, l8_v7_next, l8_v8_next, l8_v9_next, l8_v10_next, l8_v11_next, l8_v12_next, l8_v13_next), l8_reachable_header_states_recursive, name="l8_reachable_header_states_recursive")

# Header to exit
l8_header_to_exit_base = l8_exit_steps(l8_v1, l8_v2, l8_v3, l8_v4, l8_v5, l8_v6, l8_v7, l8_v8, l8_v9, l8_v10, l8_v11, l8_v12, l8_v13, l8_v1_out, l8_v2_out, l8_v3_out, l8_v4_out, l8_v5_out, l8_v6_out, l8_v7_out, l8_v8_out, l8_v9_out, l8_v10_out, l8_v11_out, l8_v12_out, l8_v13_out)
fp.rule(l8_header_to_exit(l8_v1, l8_v2, l8_v3, l8_v4, l8_v5, l8_v6, l8_v7, l8_v8, l8_v9, l8_v10, l8_v11, l8_v12, l8_v13, l8_v1_out, l8_v2_out, l8_v3_out, l8_v4_out, l8_v5_out, l8_v6_out, l8_v7_out, l8_v8_out, l8_v9_out, l8_v10_out, l8_v11_out, l8_v12_out, l8_v13_out), l8_header_to_exit_base, name="l8_header_to_exit_base")

l8_header_to_exit_recursive = And(l8_iteration_steps(l8_v1, l8_v2, l8_v3, l8_v4, l8_v5, l8_v6, l8_v7, l8_v8, l8_v9, l8_v10, l8_v11, l8_v12, l8_v13, l8_v1_next, l8_v2_next, l8_v3_next, l8_v4_next, l8_v5_next, l8_v6_next, l8_v7_next, l8_v8_next, l8_v9_next, l8_v10_next, l8_v11_next, l8_v12_next, l8_v13_next), l8_header_to_exit(l8_v1_next, l8_v2_next, l8_v3_next, l8_v4_next, l8_v5_next, l8_v6_next, l8_v7_next, l8_v8_next, l8_v9_next, l8_v10_next, l8_v11_next, l8_v12_next, l8_v13_next, l8_v1_out, l8_v2_out, l8_v3_out, l8_v4_out, l8_v5_out, l8_v6_out, l8_v7_out, l8_v8_out, l8_v9_out, l8_v10_out, l8_v11_out, l8_v12_out, l8_v13_out))
fp.rule(l8_header_to_exit(l8_v1, l8_v2, l8_v3, l8_v4, l8_v5, l8_v6, l8_v7, l8_v8, l8_v9, l8_v10, l8_v11, l8_v12, l8_v13, l8_v1_out, l8_v2_out, l8_v3_out, l8_v4_out, l8_v5_out, l8_v6_out, l8_v7_out, l8_v8_out, l8_v9_out, l8_v10_out, l8_v11_out, l8_v12_out, l8_v13_out), l8_header_to_exit_recursive, name="l8_header_to_exit_recursive")

# Header to return
l8_header_to_return_base = l8_return_steps(l8_v1, l8_v2, l8_v3, l8_v4, l8_v5, l8_v6, l8_v7, l8_v8, l8_v9, l8_v10, l8_v11, l8_v12, l8_v13)
fp.rule(l8_header_to_return(l8_v1, l8_v2, l8_v3, l8_v4, l8_v5, l8_v6, l8_v7, l8_v8, l8_v9, l8_v10, l8_v11, l8_v12, l8_v13), l8_header_to_return_base, name="l8_header_to_return_base")

l8_header_to_return_recursive = And(l8_iteration_steps(l8_v1, l8_v2, l8_v3, l8_v4, l8_v5, l8_v6, l8_v7, l8_v8, l8_v9, l8_v10, l8_v11, l8_v12, l8_v13, l8_v1_next, l8_v2_next, l8_v3_next, l8_v4_next, l8_v5_next, l8_v6_next, l8_v7_next, l8_v8_next, l8_v9_next, l8_v10_next, l8_v11_next, l8_v12_next, l8_v13_next), l8_header_to_return(l8_v1_next, l8_v2_next, l8_v3_next, l8_v4_next, l8_v5_next, l8_v6_next, l8_v7_next, l8_v8_next, l8_v9_next, l8_v10_next, l8_v11_next, l8_v12_next, l8_v13_next))
fp.rule(l8_header_to_return(l8_v1, l8_v2, l8_v3, l8_v4, l8_v5, l8_v6, l8_v7, l8_v8, l8_v9, l8_v10, l8_v11, l8_v12, l8_v13), l8_header_to_return_recursive, name="l8_header_to_return_recursive")

# Actual exit
l8_actual_exit_rule = And(l8_entry_states(l8_v1, l8_v2, l8_v3, l8_v4, l8_v5, l8_v6, l8_v7, l8_v8, l8_v9, l8_v10, l8_v11, l8_v12, l8_v13), l8_header_to_exit(l8_v1, l8_v2, l8_v3, l8_v4, l8_v5, l8_v6, l8_v7, l8_v8, l8_v9, l8_v10, l8_v11, l8_v12, l8_v13, l8_v1_out, l8_v2_out, l8_v3_out, l8_v4_out, l8_v5_out, l8_v6_out, l8_v7_out, l8_v8_out, l8_v9_out, l8_v10_out, l8_v11_out, l8_v12_out, l8_v13_out))
fp.rule(l8_actual_exit(l8_v1_out, l8_v2_out, l8_v3_out, l8_v4_out, l8_v5_out, l8_v6_out, l8_v7_out, l8_v8_out, l8_v9_out, l8_v10_out, l8_v11_out, l8_v12_out, l8_v13_out), l8_actual_exit_rule, name="l8_actual_exit_rule")

# ============================================================
# Dependency loop: l4
# ============================================================

# Guard
l4_guard = (l4_v5 < l4_v13)

# Entry states
l4_entry_states_p1 = And(BoolVal(True), l2_actual_exit(l2_v1_out, l2_v2_out, l2_v3_out, l2_v4_out, l2_v5_out, l2_v6_out, l2_v7_out, l2_v8_out, l2_v9_out, l2_v10_out, l2_v11_out, l2_v12_out, l2_v13_out), (l4_v1 == l2_v1_out), (l4_v2 == l2_v2_out), (l4_v3 == l2_v3_out), (l4_v4 == l2_v4_out), (l4_v5 == IntVal(0)), (l4_v6 == l2_v6_out), (l4_v7 == l2_v7_out), (l4_v8 == l2_v8_out), (l4_v9 == l2_v9_out), (l4_v10 == l2_v10_out), (l4_v11 == l2_v11_out), (l4_v12 == l2_v12_out), (l4_v13 == l2_v13_out))
fp.rule(l4_entry_states(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8, l4_v9, l4_v10, l4_v11, l4_v12, l4_v13), l4_entry_states_p1, name="l4_entry_states_p1")

# Iteration steps
l4_iteration_steps_p1 = And(And((l4_v5 < l4_v13), (l4_v3 != IntVal(0)), (l4_nd1 != IntVal(0)), (l6_v12_out > IntVal(1))), l5_header_to_exit(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, IntVal(0), l4_v7, l4_v8, l4_v9, IntVal(0), l4_v11, l4_v12, l4_v13, l5_v1_out, l5_v2_out, l5_v3_out, l5_v4_out, l5_v5_out, l5_v6_out, l5_v7_out, l5_v8_out, l5_v9_out, l5_v10_out, l5_v11_out, l5_v12_out, l5_v13_out), l6_header_to_exit(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l5_v6_out, IntVal(0), l4_v8, l4_v9, l5_v10_out, l4_v11, IntVal(0), l4_v13, l6_v1_out, l6_v2_out, l6_v3_out, l6_v4_out, l6_v5_out, l6_v6_out, l6_v7_out, l6_v8_out, l6_v9_out, l6_v10_out, l6_v11_out, l6_v12_out, l6_v13_out), l8_header_to_exit(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l5_v6_out, l6_v7_out, IntVal(0), l4_v9, l5_v10_out, l4_v11, l6_v12_out, l4_v13, l8_v1_out, l8_v2_out, l8_v3_out, l8_v4_out, l8_v5_out, l8_v6_out, l8_v7_out, l8_v8_out, l8_v9_out, l8_v10_out, l8_v11_out, l8_v12_out, l8_v13_out), (l4_v1_next == l4_v1), (l4_v2_next == l4_v2), (l4_v3_next == l4_v3), (l4_v4_next == l4_v4), (l4_v5_next == (l4_v5 + IntVal(1))), (l4_v6_next == l5_v6_out), (l4_v7_next == l8_v7_out), (l4_v8_next == l8_v8_out), (l4_v9_next == l4_v9), (l4_v10_next == l5_v10_out), (l4_v11_next == l8_v11_out), (l4_v12_next == l6_v12_out), (l4_v13_next == l4_v13))
fp.rule(l4_iteration_steps(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8, l4_v9, l4_v10, l4_v11, l4_v12, l4_v13, l4_v1_next, l4_v2_next, l4_v3_next, l4_v4_next, l4_v5_next, l4_v6_next, l4_v7_next, l4_v8_next, l4_v9_next, l4_v10_next, l4_v11_next, l4_v12_next, l4_v13_next), l4_iteration_steps_p1, name="l4_iteration_steps_p1")

l4_iteration_steps_p2 = And(And((l4_v5 < l4_v13), (l4_v3 != IntVal(0)), (l4_nd1 != IntVal(0)), (l6_v12_out <= IntVal(1))), l5_header_to_exit(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, IntVal(0), l4_v7, l4_v8, l4_v9, IntVal(0), l4_v11, l4_v12, l4_v13, l5_v1_out, l5_v2_out, l5_v3_out, l5_v4_out, l5_v5_out, l5_v6_out, l5_v7_out, l5_v8_out, l5_v9_out, l5_v10_out, l5_v11_out, l5_v12_out, l5_v13_out), l6_header_to_exit(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l5_v6_out, IntVal(0), l4_v8, l4_v9, l5_v10_out, l4_v11, IntVal(0), l4_v13, l6_v1_out, l6_v2_out, l6_v3_out, l6_v4_out, l6_v5_out, l6_v6_out, l6_v7_out, l6_v8_out, l6_v9_out, l6_v10_out, l6_v11_out, l6_v12_out, l6_v13_out), (l4_v1_next == l4_v1), (l4_v2_next == l4_v2), (l4_v3_next == l4_v3), (l4_v4_next == l4_v4), (l4_v5_next == (l4_v5 + IntVal(1))), (l4_v6_next == l5_v6_out), (l4_v7_next == l6_v7_out), (l4_v8_next == l6_v8_out), (l4_v9_next == l4_v9), (l4_v10_next == l5_v10_out), (l4_v11_next == l4_v11), (l4_v12_next == l6_v12_out), (l4_v13_next == l4_v13))
fp.rule(l4_iteration_steps(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8, l4_v9, l4_v10, l4_v11, l4_v12, l4_v13, l4_v1_next, l4_v2_next, l4_v3_next, l4_v4_next, l4_v5_next, l4_v6_next, l4_v7_next, l4_v8_next, l4_v9_next, l4_v10_next, l4_v11_next, l4_v12_next, l4_v13_next), l4_iteration_steps_p2, name="l4_iteration_steps_p2")

l4_iteration_steps_p3 = And(Or(And((l4_v5 < l4_v13), (l4_v3 != IntVal(0)), (l4_nd1 == IntVal(0))), And((l4_v5 < l4_v13), (l4_v3 == IntVal(0)))), l5_header_to_exit(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, IntVal(0), l4_v7, l4_v8, l4_v9, IntVal(0), l4_v11, l4_v12, l4_v13, l5_v1_out, l5_v2_out, l5_v3_out, l5_v4_out, l5_v5_out, l5_v6_out, l5_v7_out, l5_v8_out, l5_v9_out, l5_v10_out, l5_v11_out, l5_v12_out, l5_v13_out), (l4_v1_next == l4_v1), (l4_v2_next == l4_v2), (l4_v3_next == l4_v3), (l4_v4_next == l4_v4), (l4_v5_next == (l4_v5 + IntVal(1))), (l4_v6_next == l5_v6_out), (l4_v7_next == l4_v7), (l4_v8_next == l4_v8), (l4_v9_next == l4_v9), (l4_v10_next == l5_v10_out), (l4_v11_next == l4_v11), (l4_v12_next == l4_v12), (l4_v13_next == l4_v13))
fp.rule(l4_iteration_steps(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8, l4_v9, l4_v10, l4_v11, l4_v12, l4_v13, l4_v1_next, l4_v2_next, l4_v3_next, l4_v4_next, l4_v5_next, l4_v6_next, l4_v7_next, l4_v8_next, l4_v9_next, l4_v10_next, l4_v11_next, l4_v12_next, l4_v13_next), l4_iteration_steps_p3, name="l4_iteration_steps_p3")

# Exit steps
l4_exit_steps_p1 = And((l4_v5 >= l4_v13), (l4_v1_out == l4_v1), (l4_v2_out == l4_v2), (l4_v3_out == l4_v3), (l4_v4_out == l4_v4), (l4_v5_out == l4_v5), (l4_v6_out == l4_v6), (l4_v7_out == l4_v7), (l4_v8_out == l4_v8), (l4_v9_out == l4_v9), (l4_v10_out == l4_v10), (l4_v11_out == l4_v11), (l4_v12_out == l4_v12), (l4_v13_out == l4_v13))
fp.rule(l4_exit_steps(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8, l4_v9, l4_v10, l4_v11, l4_v12, l4_v13, l4_v1_out, l4_v2_out, l4_v3_out, l4_v4_out, l4_v5_out, l4_v6_out, l4_v7_out, l4_v8_out, l4_v9_out, l4_v10_out, l4_v11_out, l4_v12_out, l4_v13_out), l4_exit_steps_p1, name="l4_exit_steps_p1")

# Return steps
# Reachable header states
l4_reachable_header_states_base = l4_entry_states(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8, l4_v9, l4_v10, l4_v11, l4_v12, l4_v13)
fp.rule(l4_reachable_header_states(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8, l4_v9, l4_v10, l4_v11, l4_v12, l4_v13), l4_reachable_header_states_base, name="l4_reachable_header_states_base")

l4_reachable_header_states_recursive = And(l4_reachable_header_states(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8, l4_v9, l4_v10, l4_v11, l4_v12, l4_v13), l4_iteration_steps(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8, l4_v9, l4_v10, l4_v11, l4_v12, l4_v13, l4_v1_next, l4_v2_next, l4_v3_next, l4_v4_next, l4_v5_next, l4_v6_next, l4_v7_next, l4_v8_next, l4_v9_next, l4_v10_next, l4_v11_next, l4_v12_next, l4_v13_next))
fp.rule(l4_reachable_header_states(l4_v1_next, l4_v2_next, l4_v3_next, l4_v4_next, l4_v5_next, l4_v6_next, l4_v7_next, l4_v8_next, l4_v9_next, l4_v10_next, l4_v11_next, l4_v12_next, l4_v13_next), l4_reachable_header_states_recursive, name="l4_reachable_header_states_recursive")

# Header to exit
l4_header_to_exit_base = l4_exit_steps(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8, l4_v9, l4_v10, l4_v11, l4_v12, l4_v13, l4_v1_out, l4_v2_out, l4_v3_out, l4_v4_out, l4_v5_out, l4_v6_out, l4_v7_out, l4_v8_out, l4_v9_out, l4_v10_out, l4_v11_out, l4_v12_out, l4_v13_out)
fp.rule(l4_header_to_exit(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8, l4_v9, l4_v10, l4_v11, l4_v12, l4_v13, l4_v1_out, l4_v2_out, l4_v3_out, l4_v4_out, l4_v5_out, l4_v6_out, l4_v7_out, l4_v8_out, l4_v9_out, l4_v10_out, l4_v11_out, l4_v12_out, l4_v13_out), l4_header_to_exit_base, name="l4_header_to_exit_base")

l4_header_to_exit_recursive = And(l4_iteration_steps(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8, l4_v9, l4_v10, l4_v11, l4_v12, l4_v13, l4_v1_next, l4_v2_next, l4_v3_next, l4_v4_next, l4_v5_next, l4_v6_next, l4_v7_next, l4_v8_next, l4_v9_next, l4_v10_next, l4_v11_next, l4_v12_next, l4_v13_next), l4_header_to_exit(l4_v1_next, l4_v2_next, l4_v3_next, l4_v4_next, l4_v5_next, l4_v6_next, l4_v7_next, l4_v8_next, l4_v9_next, l4_v10_next, l4_v11_next, l4_v12_next, l4_v13_next, l4_v1_out, l4_v2_out, l4_v3_out, l4_v4_out, l4_v5_out, l4_v6_out, l4_v7_out, l4_v8_out, l4_v9_out, l4_v10_out, l4_v11_out, l4_v12_out, l4_v13_out))
fp.rule(l4_header_to_exit(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8, l4_v9, l4_v10, l4_v11, l4_v12, l4_v13, l4_v1_out, l4_v2_out, l4_v3_out, l4_v4_out, l4_v5_out, l4_v6_out, l4_v7_out, l4_v8_out, l4_v9_out, l4_v10_out, l4_v11_out, l4_v12_out, l4_v13_out), l4_header_to_exit_recursive, name="l4_header_to_exit_recursive")

# Header to return
l4_header_to_return_base = l4_return_steps(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8, l4_v9, l4_v10, l4_v11, l4_v12, l4_v13)
fp.rule(l4_header_to_return(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8, l4_v9, l4_v10, l4_v11, l4_v12, l4_v13), l4_header_to_return_base, name="l4_header_to_return_base")

l4_header_to_return_recursive = And(l4_iteration_steps(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8, l4_v9, l4_v10, l4_v11, l4_v12, l4_v13, l4_v1_next, l4_v2_next, l4_v3_next, l4_v4_next, l4_v5_next, l4_v6_next, l4_v7_next, l4_v8_next, l4_v9_next, l4_v10_next, l4_v11_next, l4_v12_next, l4_v13_next), l4_header_to_return(l4_v1_next, l4_v2_next, l4_v3_next, l4_v4_next, l4_v5_next, l4_v6_next, l4_v7_next, l4_v8_next, l4_v9_next, l4_v10_next, l4_v11_next, l4_v12_next, l4_v13_next))
fp.rule(l4_header_to_return(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8, l4_v9, l4_v10, l4_v11, l4_v12, l4_v13), l4_header_to_return_recursive, name="l4_header_to_return_recursive")

# Actual exit
l4_actual_exit_rule = And(l4_entry_states(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8, l4_v9, l4_v10, l4_v11, l4_v12, l4_v13), l4_header_to_exit(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8, l4_v9, l4_v10, l4_v11, l4_v12, l4_v13, l4_v1_out, l4_v2_out, l4_v3_out, l4_v4_out, l4_v5_out, l4_v6_out, l4_v7_out, l4_v8_out, l4_v9_out, l4_v10_out, l4_v11_out, l4_v12_out, l4_v13_out))
fp.rule(l4_actual_exit(l4_v1_out, l4_v2_out, l4_v3_out, l4_v4_out, l4_v5_out, l4_v6_out, l4_v7_out, l4_v8_out, l4_v9_out, l4_v10_out, l4_v11_out, l4_v12_out, l4_v13_out), l4_actual_exit_rule, name="l4_actual_exit_rule")

# ============================================================
# Target loop: l5
# ============================================================

# Guard
l5_guard = (l5_v6 < l5_v2)

# Entry states
l5_entry_states_p1 = And((l4_v5 < l4_v13), l4_reachable_header_states(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8, l4_v9, l4_v10, l4_v11, l4_v12, l4_v13), (l5_v1 == l4_v1), (l5_v2 == l4_v2), (l5_v3 == l4_v3), (l5_v4 == l4_v4), (l5_v5 == l4_v5), (l5_v6 == IntVal(0)), (l5_v7 == l4_v7), (l5_v8 == l4_v8), (l5_v9 == l4_v9), (l5_v10 == IntVal(0)), (l5_v11 == l4_v11), (l5_v12 == l4_v12), (l5_v13 == l4_v13))
fp.rule(l5_entry_states(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8, l5_v9, l5_v10, l5_v11, l5_v12, l5_v13), l5_entry_states_p1, name="l5_entry_states_p1")

# Iteration steps
l5_iteration_steps_p1 = And(And((l5_v6 < l5_v2), (l5_nd1 != IntVal(0))), (l5_v1_next == l5_v1), (l5_v2_next == l5_v2), (l5_v3_next == l5_v3), (l5_v4_next == l5_v4), (l5_v5_next == l5_v5), (l5_v6_next == (l5_v6 + IntVal(1))), (l5_v7_next == l5_v7), (l5_v8_next == l5_v8), (l5_v9_next == l5_v9), (l5_v10_next == (l5_v10 + IntVal(1))), (l5_v11_next == l5_v11), (l5_v12_next == l5_v12), (l5_v13_next == l5_v13))
fp.rule(l5_iteration_steps(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8, l5_v9, l5_v10, l5_v11, l5_v12, l5_v13, l5_v1_next, l5_v2_next, l5_v3_next, l5_v4_next, l5_v5_next, l5_v6_next, l5_v7_next, l5_v8_next, l5_v9_next, l5_v10_next, l5_v11_next, l5_v12_next, l5_v13_next), l5_iteration_steps_p1, name="l5_iteration_steps_p1")

l5_iteration_steps_p2 = And(And((l5_v6 < l5_v2), (l5_nd1 == IntVal(0))), (l5_v1_next == l5_v1), (l5_v2_next == l5_v2), (l5_v3_next == l5_v3), (l5_v4_next == l5_v4), (l5_v5_next == l5_v5), (l5_v6_next == (l5_v6 + IntVal(1))), (l5_v7_next == l5_v7), (l5_v8_next == l5_v8), (l5_v9_next == l5_v9), (l5_v10_next == l5_v10), (l5_v11_next == l5_v11), (l5_v12_next == l5_v12), (l5_v13_next == l5_v13))
fp.rule(l5_iteration_steps(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8, l5_v9, l5_v10, l5_v11, l5_v12, l5_v13, l5_v1_next, l5_v2_next, l5_v3_next, l5_v4_next, l5_v5_next, l5_v6_next, l5_v7_next, l5_v8_next, l5_v9_next, l5_v10_next, l5_v11_next, l5_v12_next, l5_v13_next), l5_iteration_steps_p2, name="l5_iteration_steps_p2")

# Exit steps
l5_exit_steps_p1 = And((l5_v6 >= l5_v2), (l5_v1_out == l5_v1), (l5_v2_out == l5_v2), (l5_v3_out == l5_v3), (l5_v4_out == l5_v4), (l5_v5_out == l5_v5), (l5_v6_out == l5_v6), (l5_v7_out == l5_v7), (l5_v8_out == l5_v8), (l5_v9_out == l5_v9), (l5_v10_out == l5_v10), (l5_v11_out == l5_v11), (l5_v12_out == l5_v12), (l5_v13_out == l5_v13))
fp.rule(l5_exit_steps(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8, l5_v9, l5_v10, l5_v11, l5_v12, l5_v13, l5_v1_out, l5_v2_out, l5_v3_out, l5_v4_out, l5_v5_out, l5_v6_out, l5_v7_out, l5_v8_out, l5_v9_out, l5_v10_out, l5_v11_out, l5_v12_out, l5_v13_out), l5_exit_steps_p1, name="l5_exit_steps_p1")

# Return steps
# Reachable header states
l5_reachable_header_states_base = l5_entry_states(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8, l5_v9, l5_v10, l5_v11, l5_v12, l5_v13)
fp.rule(l5_reachable_header_states(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8, l5_v9, l5_v10, l5_v11, l5_v12, l5_v13), l5_reachable_header_states_base, name="l5_reachable_header_states_base")

l5_reachable_header_states_recursive = And(l5_reachable_header_states(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8, l5_v9, l5_v10, l5_v11, l5_v12, l5_v13), l5_iteration_steps(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8, l5_v9, l5_v10, l5_v11, l5_v12, l5_v13, l5_v1_next, l5_v2_next, l5_v3_next, l5_v4_next, l5_v5_next, l5_v6_next, l5_v7_next, l5_v8_next, l5_v9_next, l5_v10_next, l5_v11_next, l5_v12_next, l5_v13_next))
fp.rule(l5_reachable_header_states(l5_v1_next, l5_v2_next, l5_v3_next, l5_v4_next, l5_v5_next, l5_v6_next, l5_v7_next, l5_v8_next, l5_v9_next, l5_v10_next, l5_v11_next, l5_v12_next, l5_v13_next), l5_reachable_header_states_recursive, name="l5_reachable_header_states_recursive")

# Header to exit
l5_header_to_exit_base = l5_exit_steps(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8, l5_v9, l5_v10, l5_v11, l5_v12, l5_v13, l5_v1_out, l5_v2_out, l5_v3_out, l5_v4_out, l5_v5_out, l5_v6_out, l5_v7_out, l5_v8_out, l5_v9_out, l5_v10_out, l5_v11_out, l5_v12_out, l5_v13_out)
fp.rule(l5_header_to_exit(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8, l5_v9, l5_v10, l5_v11, l5_v12, l5_v13, l5_v1_out, l5_v2_out, l5_v3_out, l5_v4_out, l5_v5_out, l5_v6_out, l5_v7_out, l5_v8_out, l5_v9_out, l5_v10_out, l5_v11_out, l5_v12_out, l5_v13_out), l5_header_to_exit_base, name="l5_header_to_exit_base")

l5_header_to_exit_recursive = And(l5_iteration_steps(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8, l5_v9, l5_v10, l5_v11, l5_v12, l5_v13, l5_v1_next, l5_v2_next, l5_v3_next, l5_v4_next, l5_v5_next, l5_v6_next, l5_v7_next, l5_v8_next, l5_v9_next, l5_v10_next, l5_v11_next, l5_v12_next, l5_v13_next), l5_header_to_exit(l5_v1_next, l5_v2_next, l5_v3_next, l5_v4_next, l5_v5_next, l5_v6_next, l5_v7_next, l5_v8_next, l5_v9_next, l5_v10_next, l5_v11_next, l5_v12_next, l5_v13_next, l5_v1_out, l5_v2_out, l5_v3_out, l5_v4_out, l5_v5_out, l5_v6_out, l5_v7_out, l5_v8_out, l5_v9_out, l5_v10_out, l5_v11_out, l5_v12_out, l5_v13_out))
fp.rule(l5_header_to_exit(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8, l5_v9, l5_v10, l5_v11, l5_v12, l5_v13, l5_v1_out, l5_v2_out, l5_v3_out, l5_v4_out, l5_v5_out, l5_v6_out, l5_v7_out, l5_v8_out, l5_v9_out, l5_v10_out, l5_v11_out, l5_v12_out, l5_v13_out), l5_header_to_exit_recursive, name="l5_header_to_exit_recursive")

# Header to return
l5_header_to_return_base = l5_return_steps(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8, l5_v9, l5_v10, l5_v11, l5_v12, l5_v13)
fp.rule(l5_header_to_return(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8, l5_v9, l5_v10, l5_v11, l5_v12, l5_v13), l5_header_to_return_base, name="l5_header_to_return_base")

l5_header_to_return_recursive = And(l5_iteration_steps(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8, l5_v9, l5_v10, l5_v11, l5_v12, l5_v13, l5_v1_next, l5_v2_next, l5_v3_next, l5_v4_next, l5_v5_next, l5_v6_next, l5_v7_next, l5_v8_next, l5_v9_next, l5_v10_next, l5_v11_next, l5_v12_next, l5_v13_next), l5_header_to_return(l5_v1_next, l5_v2_next, l5_v3_next, l5_v4_next, l5_v5_next, l5_v6_next, l5_v7_next, l5_v8_next, l5_v9_next, l5_v10_next, l5_v11_next, l5_v12_next, l5_v13_next))
fp.rule(l5_header_to_return(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8, l5_v9, l5_v10, l5_v11, l5_v12, l5_v13), l5_header_to_return_recursive, name="l5_header_to_return_recursive")

# Actual exit
l5_actual_exit_rule = And(l5_entry_states(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8, l5_v9, l5_v10, l5_v11, l5_v12, l5_v13), l5_header_to_exit(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8, l5_v9, l5_v10, l5_v11, l5_v12, l5_v13, l5_v1_out, l5_v2_out, l5_v3_out, l5_v4_out, l5_v5_out, l5_v6_out, l5_v7_out, l5_v8_out, l5_v9_out, l5_v10_out, l5_v11_out, l5_v12_out, l5_v13_out))
fp.rule(l5_actual_exit(l5_v1_out, l5_v2_out, l5_v3_out, l5_v4_out, l5_v5_out, l5_v6_out, l5_v7_out, l5_v8_out, l5_v9_out, l5_v10_out, l5_v11_out, l5_v12_out, l5_v13_out), l5_actual_exit_rule, name="l5_actual_exit_rule")

# ============================================================
# Target candidate: l5 (terminating)
# ============================================================

l5_invariant = And((l5_v6 >= IntVal(0)), (l5_v6 <= l5_v2))
l5_invariant_next = And((l5_v6_next >= IntVal(0)), (l5_v6_next <= l5_v2_next))

l5_ranking_function = [(l5_v2 - l5_v6)]
l5_ranking_function_next = [(l5_v2_next - l5_v6_next)]

# ============================================================
# Termination validation
# ============================================================

l5_bad_invariant_initialization = Function("l5_bad_invariant_initialization", BoolSort())
fp.register_relation(l5_bad_invariant_initialization)
fp.rule(l5_bad_invariant_initialization(), And(l5_entry_states(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8, l5_v9, l5_v10, l5_v11, l5_v12, l5_v13), Not(l5_invariant)), name="l5_bad_invariant_initialization_rule")

l5_bad_invariant_preservation = Function("l5_bad_invariant_preservation", BoolSort())
fp.register_relation(l5_bad_invariant_preservation)
fp.rule(l5_bad_invariant_preservation(), And(l5_invariant, l5_guard, l5_iteration_steps(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8, l5_v9, l5_v10, l5_v11, l5_v12, l5_v13, l5_v1_next, l5_v2_next, l5_v3_next, l5_v4_next, l5_v5_next, l5_v6_next, l5_v7_next, l5_v8_next, l5_v9_next, l5_v10_next, l5_v11_next, l5_v12_next, l5_v13_next), Not(l5_invariant_next)), name="l5_bad_invariant_preservation_rule")

l5_ranking_nonnegativity_solver = Solver()
l5_ranking_nonnegativity_solver.add(l5_invariant, l5_guard, l5_ranking_function[0] < 0)

l5_ranking_decrease_solver = Solver()
l5_ranking_decrease_solver.add(l5_invariant, l5_guard, Or(l5_iteration_steps_p1, l5_iteration_steps_p2), Not(l5_ranking_function_next[0] < l5_ranking_function[0]))

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

l5_invariant_initialization_result = check_fixedpoint(
    "INVARIANT_INITIALIZATION",
    l5_bad_invariant_initialization,
    unsat,
    "a reachable entry state violates the invariant."
)

l5_invariant_preservation_result = check_fixedpoint(
    "INVARIANT_PRESERVATION",
    l5_bad_invariant_preservation,
    unsat,
    "a completed loop iteration can reach a next state that violates the invariant."
)

l5_ranking_nonnegativity_result = check_solver(
    "RANKING_NONNEGATIVITY",
    l5_ranking_nonnegativity_solver,
    unsat,
    "the ranking function can be negative while the invariant and loop guard hold."
)

l5_ranking_decrease_result = check_solver(
    "RANKING_DECREASE",
    l5_ranking_decrease_solver,
    unsat,
    "a completed loop iteration can fail to strictly decrease the ranking function."
)

INVARIANT_RESULT = validation_status([
    (l5_invariant_initialization_result, unsat),
    (l5_invariant_preservation_result, unsat)
])

RANKING_FUNCTION_RESULT = validation_status([
    (l5_ranking_nonnegativity_result, unsat),
    (l5_ranking_decrease_result, unsat)
])

print()
print(f'INVARIANT_RESULT: "{INVARIANT_RESULT}"')
print(f'RANKING_FUNCTION_RESULT: "{RANKING_FUNCTION_RESULT}"')
emit_validation_summary("l5", "terminating", {"invariant": INVARIANT_RESULT, "ranking_function": RANKING_FUNCTION_RESULT})
