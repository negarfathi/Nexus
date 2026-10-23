print('===================== SEMANTIC FEEDBACK =====================')
print('TARGET_LOOP: l5')
print('CANDIDATE_KIND: non-terminating')
print()
print('RECURRENT_SET:')
print("{\n  \"op\": \">=\",\n  \"args\": [\n    \"l5_v6\",\n    0\n  ]\n}")
print()
print('FEEDBACK:')
#!/usr/bin/env python3

from z3 import *
import sys
import time

VALIDATION_TIMEOUT_MS = 586190
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
l1_state = [l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8]
l1_next_state = [l1_v1_next, l1_v2_next, l1_v3_next, l1_v4_next, l1_v5_next, l1_v6_next, l1_v7_next, l1_v8_next]
l1_output_state = [l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out, l1_v5_out, l1_v6_out, l1_v7_out, l1_v8_out]

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
l2_state = [l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8]
l2_next_state = [l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next, l2_v5_next, l2_v6_next, l2_v7_next, l2_v8_next]
l2_output_state = [l2_v1_out, l2_v2_out, l2_v3_out, l2_v4_out, l2_v5_out, l2_v6_out, l2_v7_out, l2_v8_out]

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
l3_state = [l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8]
l3_next_state = [l3_v1_next, l3_v2_next, l3_v3_next, l3_v4_next, l3_v5_next, l3_v6_next, l3_v7_next, l3_v8_next]
l3_output_state = [l3_v1_out, l3_v2_out, l3_v3_out, l3_v4_out, l3_v5_out, l3_v6_out, l3_v7_out, l3_v8_out]

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
l4_state = [l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8]
l4_next_state = [l4_v1_next, l4_v2_next, l4_v3_next, l4_v4_next, l4_v5_next, l4_v6_next, l4_v7_next, l4_v8_next]
l4_output_state = [l4_v1_out, l4_v2_out, l4_v3_out, l4_v4_out, l4_v5_out, l4_v6_out, l4_v7_out, l4_v8_out]

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
l5_state = [l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8]
l5_next_state = [l5_v1_next, l5_v2_next, l5_v3_next, l5_v4_next, l5_v5_next, l5_v6_next, l5_v7_next, l5_v8_next]
l5_output_state = [l5_v1_out, l5_v2_out, l5_v3_out, l5_v4_out, l5_v5_out, l5_v6_out, l5_v7_out, l5_v8_out]

# ============================================================
# Relation declarations
# ============================================================

# l1
l1_entry_states = Function("l1_entry_states", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_entry_states)
l1_iteration_steps = Function("l1_iteration_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_iteration_steps)
l1_exit_steps = Function("l1_exit_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_exit_steps)
l1_return_steps = Function("l1_return_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_return_steps)
l1_reachable_header_states = Function("l1_reachable_header_states", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_reachable_header_states)
l1_header_to_exit = Function("l1_header_to_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_header_to_exit)
l1_header_to_return = Function("l1_header_to_return", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_header_to_return)
l1_actual_exit = Function("l1_actual_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l1_actual_exit)

# l2
l2_entry_states = Function("l2_entry_states", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l2_entry_states)
l2_iteration_steps = Function("l2_iteration_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l2_iteration_steps)
l2_exit_steps = Function("l2_exit_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l2_exit_steps)
l2_return_steps = Function("l2_return_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l2_return_steps)
l2_reachable_header_states = Function("l2_reachable_header_states", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l2_reachable_header_states)
l2_header_to_exit = Function("l2_header_to_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l2_header_to_exit)
l2_header_to_return = Function("l2_header_to_return", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l2_header_to_return)
l2_actual_exit = Function("l2_actual_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l2_actual_exit)

# l3
l3_entry_states = Function("l3_entry_states", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l3_entry_states)
l3_iteration_steps = Function("l3_iteration_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l3_iteration_steps)
l3_exit_steps = Function("l3_exit_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l3_exit_steps)
l3_return_steps = Function("l3_return_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l3_return_steps)
l3_reachable_header_states = Function("l3_reachable_header_states", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l3_reachable_header_states)
l3_header_to_exit = Function("l3_header_to_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l3_header_to_exit)
l3_header_to_return = Function("l3_header_to_return", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l3_header_to_return)
l3_actual_exit = Function("l3_actual_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l3_actual_exit)

# l4
l4_entry_states = Function("l4_entry_states", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l4_entry_states)
l4_iteration_steps = Function("l4_iteration_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l4_iteration_steps)
l4_exit_steps = Function("l4_exit_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l4_exit_steps)
l4_return_steps = Function("l4_return_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l4_return_steps)
l4_reachable_header_states = Function("l4_reachable_header_states", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l4_reachable_header_states)
l4_header_to_exit = Function("l4_header_to_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l4_header_to_exit)
l4_header_to_return = Function("l4_header_to_return", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l4_header_to_return)
l4_actual_exit = Function("l4_actual_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l4_actual_exit)

# l5
l5_entry_states = Function("l5_entry_states", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l5_entry_states)
l5_iteration_steps = Function("l5_iteration_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l5_iteration_steps)
l5_exit_steps = Function("l5_exit_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l5_exit_steps)
l5_return_steps = Function("l5_return_steps", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l5_return_steps)
l5_reachable_header_states = Function("l5_reachable_header_states", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l5_reachable_header_states)
l5_header_to_exit = Function("l5_header_to_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l5_header_to_exit)
l5_header_to_return = Function("l5_header_to_return", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l5_header_to_return)
l5_actual_exit = Function("l5_actual_exit", IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), IntSort(), BoolSort())
fp.register_relation(l5_actual_exit)

# ============================================================
# Dependency loop: l1
# ============================================================

# Guard
l1_guard = (l1_v2 < IntVal(100))

# Entry states
l1_entry_states_p1 = And(BoolVal(True), (l1_v1 == IntVal(0)), (l1_v2 == IntVal(0)), (l1_v3 == l1_v3), (l1_v4 == l1_v4), (l1_v5 == l1_v5), (l1_v6 == l1_v6), (l1_v7 == l1_v7), (l1_v8 == l1_v8))
fp.rule(l1_entry_states(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8), l1_entry_states_p1, name="l1_entry_states_p1")

# Iteration steps
l1_iteration_steps_p1 = And((l1_v2 < IntVal(100)), l2_header_to_exit(l1_v1, l1_v2, IntVal(0), l1_v4, l1_v5, l1_v6, (l1_v2 + IntVal(2)), l1_v8, l2_v1_out, l2_v2_out, l2_v3_out, l2_v4_out, l2_v5_out, l2_v6_out, l2_v7_out, l2_v8_out), (l1_v1_next == l1_v1), (l1_v2_next == (l1_v2 + IntVal(1))), (l1_v3_next == l2_v3_out), (l1_v4_next == l2_v4_out), (l1_v5_next == l2_v5_out), (l1_v6_next == l2_v6_out), (l1_v7_next == (l1_v2 + IntVal(2))), (l1_v8_next == l2_v8_out))
fp.rule(l1_iteration_steps(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8, l1_v1_next, l1_v2_next, l1_v3_next, l1_v4_next, l1_v5_next, l1_v6_next, l1_v7_next, l1_v8_next), l1_iteration_steps_p1, name="l1_iteration_steps_p1")

# Exit steps
l1_exit_steps_p1 = And((l1_v2 >= IntVal(100)), (l1_v1_out == l1_v1), (l1_v2_out == l1_v2), (l1_v3_out == l1_v3), (l1_v4_out == l1_v4), (l1_v5_out == l1_v5), (l1_v6_out == l1_v6), (l1_v7_out == l1_v7), (l1_v8_out == l1_v8))
fp.rule(l1_exit_steps(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8, l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out, l1_v5_out, l1_v6_out, l1_v7_out, l1_v8_out), l1_exit_steps_p1, name="l1_exit_steps_p1")

# Return steps
# Reachable header states
l1_reachable_header_states_base = l1_entry_states(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8)
fp.rule(l1_reachable_header_states(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8), l1_reachable_header_states_base, name="l1_reachable_header_states_base")

l1_reachable_header_states_recursive = And(l1_reachable_header_states(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8), l1_iteration_steps(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8, l1_v1_next, l1_v2_next, l1_v3_next, l1_v4_next, l1_v5_next, l1_v6_next, l1_v7_next, l1_v8_next))
fp.rule(l1_reachable_header_states(l1_v1_next, l1_v2_next, l1_v3_next, l1_v4_next, l1_v5_next, l1_v6_next, l1_v7_next, l1_v8_next), l1_reachable_header_states_recursive, name="l1_reachable_header_states_recursive")

# Header to exit
l1_header_to_exit_base = l1_exit_steps(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8, l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out, l1_v5_out, l1_v6_out, l1_v7_out, l1_v8_out)
fp.rule(l1_header_to_exit(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8, l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out, l1_v5_out, l1_v6_out, l1_v7_out, l1_v8_out), l1_header_to_exit_base, name="l1_header_to_exit_base")

l1_header_to_exit_recursive = And(l1_iteration_steps(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8, l1_v1_next, l1_v2_next, l1_v3_next, l1_v4_next, l1_v5_next, l1_v6_next, l1_v7_next, l1_v8_next), l1_header_to_exit(l1_v1_next, l1_v2_next, l1_v3_next, l1_v4_next, l1_v5_next, l1_v6_next, l1_v7_next, l1_v8_next, l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out, l1_v5_out, l1_v6_out, l1_v7_out, l1_v8_out))
fp.rule(l1_header_to_exit(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8, l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out, l1_v5_out, l1_v6_out, l1_v7_out, l1_v8_out), l1_header_to_exit_recursive, name="l1_header_to_exit_recursive")

# Header to return
l1_header_to_return_base = l1_return_steps(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8)
fp.rule(l1_header_to_return(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8), l1_header_to_return_base, name="l1_header_to_return_base")

l1_header_to_return_recursive = And(l1_iteration_steps(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8, l1_v1_next, l1_v2_next, l1_v3_next, l1_v4_next, l1_v5_next, l1_v6_next, l1_v7_next, l1_v8_next), l1_header_to_return(l1_v1_next, l1_v2_next, l1_v3_next, l1_v4_next, l1_v5_next, l1_v6_next, l1_v7_next, l1_v8_next))
fp.rule(l1_header_to_return(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8), l1_header_to_return_recursive, name="l1_header_to_return_recursive")

# Actual exit
l1_actual_exit_rule = And(l1_entry_states(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8), l1_header_to_exit(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8, l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out, l1_v5_out, l1_v6_out, l1_v7_out, l1_v8_out))
fp.rule(l1_actual_exit(l1_v1_out, l1_v2_out, l1_v3_out, l1_v4_out, l1_v5_out, l1_v6_out, l1_v7_out, l1_v8_out), l1_actual_exit_rule, name="l1_actual_exit_rule")

# ============================================================
# Dependency loop: l2
# ============================================================

# Guard
l2_guard = (l2_v3 < l2_v7)

# Entry states
l2_entry_states_p1 = And((l1_v2 < IntVal(100)), l1_reachable_header_states(l1_v1, l1_v2, l1_v3, l1_v4, l1_v5, l1_v6, l1_v7, l1_v8), (l2_v1 == l1_v1), (l2_v2 == l1_v2), (l2_v3 == IntVal(0)), (l2_v4 == l1_v4), (l2_v5 == l1_v5), (l2_v6 == l1_v6), (l2_v7 == (l1_v2 + IntVal(2))), (l2_v8 == l1_v8))
fp.rule(l2_entry_states(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8), l2_entry_states_p1, name="l2_entry_states_p1")

# Iteration steps
l2_iteration_steps_p1 = And((l2_v3 < l2_v7), l3_header_to_exit(l2_v1, l2_v2, l2_v3, ((l2_v2 + l2_v3) + IntVal(3)), l2_v5, l2_v6, l2_v7, l2_v8, l3_v1_out, l3_v2_out, l3_v3_out, l3_v4_out, l3_v5_out, l3_v6_out, l3_v7_out, l3_v8_out), (l2_v1_next == l2_v1), (l2_v2_next == l2_v2), (l2_v3_next == (l2_v3 + IntVal(1))), (l2_v4_next == l3_v4_out), (l2_v5_next == l3_v5_out), (l2_v6_next == l3_v6_out), (l2_v7_next == l2_v7), (l2_v8_next == l3_v8_out))
fp.rule(l2_iteration_steps(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8, l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next, l2_v5_next, l2_v6_next, l2_v7_next, l2_v8_next), l2_iteration_steps_p1, name="l2_iteration_steps_p1")

# Exit steps
l2_exit_steps_p1 = And((l2_v3 >= l2_v7), (l2_v1_out == l2_v1), (l2_v2_out == l2_v2), (l2_v3_out == l2_v3), (l2_v4_out == l2_v4), (l2_v5_out == l2_v5), (l2_v6_out == l2_v6), (l2_v7_out == l2_v7), (l2_v8_out == l2_v8))
fp.rule(l2_exit_steps(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8, l2_v1_out, l2_v2_out, l2_v3_out, l2_v4_out, l2_v5_out, l2_v6_out, l2_v7_out, l2_v8_out), l2_exit_steps_p1, name="l2_exit_steps_p1")

# Return steps
# Reachable header states
l2_reachable_header_states_base = l2_entry_states(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8)
fp.rule(l2_reachable_header_states(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8), l2_reachable_header_states_base, name="l2_reachable_header_states_base")

l2_reachable_header_states_recursive = And(l2_reachable_header_states(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8), l2_iteration_steps(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8, l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next, l2_v5_next, l2_v6_next, l2_v7_next, l2_v8_next))
fp.rule(l2_reachable_header_states(l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next, l2_v5_next, l2_v6_next, l2_v7_next, l2_v8_next), l2_reachable_header_states_recursive, name="l2_reachable_header_states_recursive")

# Header to exit
l2_header_to_exit_base = l2_exit_steps(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8, l2_v1_out, l2_v2_out, l2_v3_out, l2_v4_out, l2_v5_out, l2_v6_out, l2_v7_out, l2_v8_out)
fp.rule(l2_header_to_exit(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8, l2_v1_out, l2_v2_out, l2_v3_out, l2_v4_out, l2_v5_out, l2_v6_out, l2_v7_out, l2_v8_out), l2_header_to_exit_base, name="l2_header_to_exit_base")

l2_header_to_exit_recursive = And(l2_iteration_steps(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8, l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next, l2_v5_next, l2_v6_next, l2_v7_next, l2_v8_next), l2_header_to_exit(l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next, l2_v5_next, l2_v6_next, l2_v7_next, l2_v8_next, l2_v1_out, l2_v2_out, l2_v3_out, l2_v4_out, l2_v5_out, l2_v6_out, l2_v7_out, l2_v8_out))
fp.rule(l2_header_to_exit(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8, l2_v1_out, l2_v2_out, l2_v3_out, l2_v4_out, l2_v5_out, l2_v6_out, l2_v7_out, l2_v8_out), l2_header_to_exit_recursive, name="l2_header_to_exit_recursive")

# Header to return
l2_header_to_return_base = l2_return_steps(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8)
fp.rule(l2_header_to_return(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8), l2_header_to_return_base, name="l2_header_to_return_base")

l2_header_to_return_recursive = And(l2_iteration_steps(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8, l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next, l2_v5_next, l2_v6_next, l2_v7_next, l2_v8_next), l2_header_to_return(l2_v1_next, l2_v2_next, l2_v3_next, l2_v4_next, l2_v5_next, l2_v6_next, l2_v7_next, l2_v8_next))
fp.rule(l2_header_to_return(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8), l2_header_to_return_recursive, name="l2_header_to_return_recursive")

# Actual exit
l2_actual_exit_rule = And(l2_entry_states(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8), l2_header_to_exit(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8, l2_v1_out, l2_v2_out, l2_v3_out, l2_v4_out, l2_v5_out, l2_v6_out, l2_v7_out, l2_v8_out))
fp.rule(l2_actual_exit(l2_v1_out, l2_v2_out, l2_v3_out, l2_v4_out, l2_v5_out, l2_v6_out, l2_v7_out, l2_v8_out), l2_actual_exit_rule, name="l2_actual_exit_rule")

# ============================================================
# Dependency loop: l3
# ============================================================

# Guard
l3_guard = (l3_v4 >= IntVal(0))

# Entry states
l3_entry_states_p1 = And((l2_v3 < l2_v7), l2_reachable_header_states(l2_v1, l2_v2, l2_v3, l2_v4, l2_v5, l2_v6, l2_v7, l2_v8), (l3_v1 == l2_v1), (l3_v2 == l2_v2), (l3_v3 == l2_v3), (l3_v4 == ((l2_v2 + l2_v3) + IntVal(3))), (l3_v5 == l2_v5), (l3_v6 == l2_v6), (l3_v7 == l2_v7), (l3_v8 == l2_v8))
fp.rule(l3_entry_states(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8), l3_entry_states_p1, name="l3_entry_states_p1")

# Iteration steps
l3_iteration_steps_p1 = And((l3_v4 >= IntVal(0)), l4_header_to_exit(l3_v1, l3_v2, l3_v3, l3_v4, IntVal(0), l3_v6, l3_v7, (((l3_v2 + l3_v3) + l3_v4) + IntVal(4)), l4_v1_out, l4_v2_out, l4_v3_out, l4_v4_out, l4_v5_out, l4_v6_out, l4_v7_out, l4_v8_out), (l3_v1_next == l3_v1), (l3_v2_next == l3_v2), (l3_v3_next == l3_v3), (l3_v4_next == (l3_v4 - IntVal(1))), (l3_v5_next == l4_v5_out), (l3_v6_next == l4_v6_out), (l3_v7_next == l3_v7), (l3_v8_next == (((l3_v2 + l3_v3) + l3_v4) + IntVal(4))))
fp.rule(l3_iteration_steps(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8, l3_v1_next, l3_v2_next, l3_v3_next, l3_v4_next, l3_v5_next, l3_v6_next, l3_v7_next, l3_v8_next), l3_iteration_steps_p1, name="l3_iteration_steps_p1")

# Exit steps
l3_exit_steps_p1 = And((l3_v4 < IntVal(0)), (l3_v1_out == l3_v1), (l3_v2_out == l3_v2), (l3_v3_out == l3_v3), (l3_v4_out == l3_v4), (l3_v5_out == l3_v5), (l3_v6_out == l3_v6), (l3_v7_out == l3_v7), (l3_v8_out == l3_v8))
fp.rule(l3_exit_steps(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8, l3_v1_out, l3_v2_out, l3_v3_out, l3_v4_out, l3_v5_out, l3_v6_out, l3_v7_out, l3_v8_out), l3_exit_steps_p1, name="l3_exit_steps_p1")

# Return steps
# Reachable header states
l3_reachable_header_states_base = l3_entry_states(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8)
fp.rule(l3_reachable_header_states(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8), l3_reachable_header_states_base, name="l3_reachable_header_states_base")

l3_reachable_header_states_recursive = And(l3_reachable_header_states(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8), l3_iteration_steps(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8, l3_v1_next, l3_v2_next, l3_v3_next, l3_v4_next, l3_v5_next, l3_v6_next, l3_v7_next, l3_v8_next))
fp.rule(l3_reachable_header_states(l3_v1_next, l3_v2_next, l3_v3_next, l3_v4_next, l3_v5_next, l3_v6_next, l3_v7_next, l3_v8_next), l3_reachable_header_states_recursive, name="l3_reachable_header_states_recursive")

# Header to exit
l3_header_to_exit_base = l3_exit_steps(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8, l3_v1_out, l3_v2_out, l3_v3_out, l3_v4_out, l3_v5_out, l3_v6_out, l3_v7_out, l3_v8_out)
fp.rule(l3_header_to_exit(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8, l3_v1_out, l3_v2_out, l3_v3_out, l3_v4_out, l3_v5_out, l3_v6_out, l3_v7_out, l3_v8_out), l3_header_to_exit_base, name="l3_header_to_exit_base")

l3_header_to_exit_recursive = And(l3_iteration_steps(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8, l3_v1_next, l3_v2_next, l3_v3_next, l3_v4_next, l3_v5_next, l3_v6_next, l3_v7_next, l3_v8_next), l3_header_to_exit(l3_v1_next, l3_v2_next, l3_v3_next, l3_v4_next, l3_v5_next, l3_v6_next, l3_v7_next, l3_v8_next, l3_v1_out, l3_v2_out, l3_v3_out, l3_v4_out, l3_v5_out, l3_v6_out, l3_v7_out, l3_v8_out))
fp.rule(l3_header_to_exit(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8, l3_v1_out, l3_v2_out, l3_v3_out, l3_v4_out, l3_v5_out, l3_v6_out, l3_v7_out, l3_v8_out), l3_header_to_exit_recursive, name="l3_header_to_exit_recursive")

# Header to return
l3_header_to_return_base = l3_return_steps(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8)
fp.rule(l3_header_to_return(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8), l3_header_to_return_base, name="l3_header_to_return_base")

l3_header_to_return_recursive = And(l3_iteration_steps(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8, l3_v1_next, l3_v2_next, l3_v3_next, l3_v4_next, l3_v5_next, l3_v6_next, l3_v7_next, l3_v8_next), l3_header_to_return(l3_v1_next, l3_v2_next, l3_v3_next, l3_v4_next, l3_v5_next, l3_v6_next, l3_v7_next, l3_v8_next))
fp.rule(l3_header_to_return(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8), l3_header_to_return_recursive, name="l3_header_to_return_recursive")

# Actual exit
l3_actual_exit_rule = And(l3_entry_states(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8), l3_header_to_exit(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8, l3_v1_out, l3_v2_out, l3_v3_out, l3_v4_out, l3_v5_out, l3_v6_out, l3_v7_out, l3_v8_out))
fp.rule(l3_actual_exit(l3_v1_out, l3_v2_out, l3_v3_out, l3_v4_out, l3_v5_out, l3_v6_out, l3_v7_out, l3_v8_out), l3_actual_exit_rule, name="l3_actual_exit_rule")

# ============================================================
# Dependency loop: l4
# ============================================================

# Guard
l4_guard = (l4_v5 < l4_v8)

# Entry states
l4_entry_states_p1 = And((l3_v4 >= IntVal(0)), l3_reachable_header_states(l3_v1, l3_v2, l3_v3, l3_v4, l3_v5, l3_v6, l3_v7, l3_v8), (l4_v1 == l3_v1), (l4_v2 == l3_v2), (l4_v3 == l3_v3), (l4_v4 == l3_v4), (l4_v5 == IntVal(0)), (l4_v6 == l3_v6), (l4_v7 == l3_v7), (l4_v8 == (((l3_v2 + l3_v3) + l3_v4) + IntVal(4))))
fp.rule(l4_entry_states(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8), l4_entry_states_p1, name="l4_entry_states_p1")

# Iteration steps
l4_iteration_steps_p1 = And((l4_v5 < l4_v8), l5_header_to_exit(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, ((((l4_v2 + l4_v3) + l4_v4) + l4_v5) + IntVal(1000)), l4_v7, l4_v8, l5_v1_out, l5_v2_out, l5_v3_out, l5_v4_out, l5_v5_out, l5_v6_out, l5_v7_out, l5_v8_out), (l4_v1_next == l4_v1), (l4_v2_next == l4_v2), (l4_v3_next == l4_v3), (l4_v4_next == l4_v4), (l4_v5_next == (l4_v5 + IntVal(1))), (l4_v6_next == l5_v6_out), (l4_v7_next == l4_v7), (l4_v8_next == l4_v8))
fp.rule(l4_iteration_steps(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8, l4_v1_next, l4_v2_next, l4_v3_next, l4_v4_next, l4_v5_next, l4_v6_next, l4_v7_next, l4_v8_next), l4_iteration_steps_p1, name="l4_iteration_steps_p1")

# Exit steps
l4_exit_steps_p1 = And((l4_v5 >= l4_v8), (l4_v1_out == l4_v1), (l4_v2_out == l4_v2), (l4_v3_out == l4_v3), (l4_v4_out == l4_v4), (l4_v5_out == l4_v5), (l4_v6_out == l4_v6), (l4_v7_out == l4_v7), (l4_v8_out == l4_v8))
fp.rule(l4_exit_steps(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8, l4_v1_out, l4_v2_out, l4_v3_out, l4_v4_out, l4_v5_out, l4_v6_out, l4_v7_out, l4_v8_out), l4_exit_steps_p1, name="l4_exit_steps_p1")

# Return steps
# Reachable header states
l4_reachable_header_states_base = l4_entry_states(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8)
fp.rule(l4_reachable_header_states(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8), l4_reachable_header_states_base, name="l4_reachable_header_states_base")

l4_reachable_header_states_recursive = And(l4_reachable_header_states(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8), l4_iteration_steps(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8, l4_v1_next, l4_v2_next, l4_v3_next, l4_v4_next, l4_v5_next, l4_v6_next, l4_v7_next, l4_v8_next))
fp.rule(l4_reachable_header_states(l4_v1_next, l4_v2_next, l4_v3_next, l4_v4_next, l4_v5_next, l4_v6_next, l4_v7_next, l4_v8_next), l4_reachable_header_states_recursive, name="l4_reachable_header_states_recursive")

# Header to exit
l4_header_to_exit_base = l4_exit_steps(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8, l4_v1_out, l4_v2_out, l4_v3_out, l4_v4_out, l4_v5_out, l4_v6_out, l4_v7_out, l4_v8_out)
fp.rule(l4_header_to_exit(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8, l4_v1_out, l4_v2_out, l4_v3_out, l4_v4_out, l4_v5_out, l4_v6_out, l4_v7_out, l4_v8_out), l4_header_to_exit_base, name="l4_header_to_exit_base")

l4_header_to_exit_recursive = And(l4_iteration_steps(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8, l4_v1_next, l4_v2_next, l4_v3_next, l4_v4_next, l4_v5_next, l4_v6_next, l4_v7_next, l4_v8_next), l4_header_to_exit(l4_v1_next, l4_v2_next, l4_v3_next, l4_v4_next, l4_v5_next, l4_v6_next, l4_v7_next, l4_v8_next, l4_v1_out, l4_v2_out, l4_v3_out, l4_v4_out, l4_v5_out, l4_v6_out, l4_v7_out, l4_v8_out))
fp.rule(l4_header_to_exit(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8, l4_v1_out, l4_v2_out, l4_v3_out, l4_v4_out, l4_v5_out, l4_v6_out, l4_v7_out, l4_v8_out), l4_header_to_exit_recursive, name="l4_header_to_exit_recursive")

# Header to return
l4_header_to_return_base = l4_return_steps(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8)
fp.rule(l4_header_to_return(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8), l4_header_to_return_base, name="l4_header_to_return_base")

l4_header_to_return_recursive = And(l4_iteration_steps(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8, l4_v1_next, l4_v2_next, l4_v3_next, l4_v4_next, l4_v5_next, l4_v6_next, l4_v7_next, l4_v8_next), l4_header_to_return(l4_v1_next, l4_v2_next, l4_v3_next, l4_v4_next, l4_v5_next, l4_v6_next, l4_v7_next, l4_v8_next))
fp.rule(l4_header_to_return(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8), l4_header_to_return_recursive, name="l4_header_to_return_recursive")

# Actual exit
l4_actual_exit_rule = And(l4_entry_states(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8), l4_header_to_exit(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8, l4_v1_out, l4_v2_out, l4_v3_out, l4_v4_out, l4_v5_out, l4_v6_out, l4_v7_out, l4_v8_out))
fp.rule(l4_actual_exit(l4_v1_out, l4_v2_out, l4_v3_out, l4_v4_out, l4_v5_out, l4_v6_out, l4_v7_out, l4_v8_out), l4_actual_exit_rule, name="l4_actual_exit_rule")

# ============================================================
# Target loop: l5
# ============================================================

# Guard
l5_guard = (l5_v6 >= IntVal(0))

# Entry states
l5_entry_states_p1 = And((l4_v5 < l4_v8), l4_reachable_header_states(l4_v1, l4_v2, l4_v3, l4_v4, l4_v5, l4_v6, l4_v7, l4_v8), (l5_v1 == l4_v1), (l5_v2 == l4_v2), (l5_v3 == l4_v3), (l5_v4 == l4_v4), (l5_v5 == l4_v5), (l5_v6 == ((((l4_v2 + l4_v3) + l4_v4) + l4_v5) + IntVal(1000))), (l5_v7 == l4_v7), (l5_v8 == l4_v8))
fp.rule(l5_entry_states(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8), l5_entry_states_p1, name="l5_entry_states_p1")

# Iteration steps
l5_iteration_steps_p1 = And((l5_v6 >= IntVal(0)), (l5_v1_next == l5_v1), (l5_v2_next == l5_v2), (l5_v3_next == l5_v3), (l5_v4_next == l5_v4), (l5_v5_next == l5_v5), (l5_v6_next == (l5_v6 - IntVal(0))), (l5_v7_next == l5_v7), (l5_v8_next == l5_v8))
fp.rule(l5_iteration_steps(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8, l5_v1_next, l5_v2_next, l5_v3_next, l5_v4_next, l5_v5_next, l5_v6_next, l5_v7_next, l5_v8_next), l5_iteration_steps_p1, name="l5_iteration_steps_p1")

# Exit steps
l5_exit_steps_p1 = And((l5_v6 < IntVal(0)), (l5_v1_out == l5_v1), (l5_v2_out == l5_v2), (l5_v3_out == l5_v3), (l5_v4_out == l5_v4), (l5_v5_out == l5_v5), (l5_v6_out == l5_v6), (l5_v7_out == l5_v7), (l5_v8_out == l5_v8))
fp.rule(l5_exit_steps(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8, l5_v1_out, l5_v2_out, l5_v3_out, l5_v4_out, l5_v5_out, l5_v6_out, l5_v7_out, l5_v8_out), l5_exit_steps_p1, name="l5_exit_steps_p1")

# Return steps
# Reachable header states
l5_reachable_header_states_base = l5_entry_states(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8)
fp.rule(l5_reachable_header_states(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8), l5_reachable_header_states_base, name="l5_reachable_header_states_base")

l5_reachable_header_states_recursive = And(l5_reachable_header_states(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8), l5_iteration_steps(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8, l5_v1_next, l5_v2_next, l5_v3_next, l5_v4_next, l5_v5_next, l5_v6_next, l5_v7_next, l5_v8_next))
fp.rule(l5_reachable_header_states(l5_v1_next, l5_v2_next, l5_v3_next, l5_v4_next, l5_v5_next, l5_v6_next, l5_v7_next, l5_v8_next), l5_reachable_header_states_recursive, name="l5_reachable_header_states_recursive")

# Header to exit
l5_header_to_exit_base = l5_exit_steps(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8, l5_v1_out, l5_v2_out, l5_v3_out, l5_v4_out, l5_v5_out, l5_v6_out, l5_v7_out, l5_v8_out)
fp.rule(l5_header_to_exit(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8, l5_v1_out, l5_v2_out, l5_v3_out, l5_v4_out, l5_v5_out, l5_v6_out, l5_v7_out, l5_v8_out), l5_header_to_exit_base, name="l5_header_to_exit_base")

l5_header_to_exit_recursive = And(l5_iteration_steps(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8, l5_v1_next, l5_v2_next, l5_v3_next, l5_v4_next, l5_v5_next, l5_v6_next, l5_v7_next, l5_v8_next), l5_header_to_exit(l5_v1_next, l5_v2_next, l5_v3_next, l5_v4_next, l5_v5_next, l5_v6_next, l5_v7_next, l5_v8_next, l5_v1_out, l5_v2_out, l5_v3_out, l5_v4_out, l5_v5_out, l5_v6_out, l5_v7_out, l5_v8_out))
fp.rule(l5_header_to_exit(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8, l5_v1_out, l5_v2_out, l5_v3_out, l5_v4_out, l5_v5_out, l5_v6_out, l5_v7_out, l5_v8_out), l5_header_to_exit_recursive, name="l5_header_to_exit_recursive")

# Header to return
l5_header_to_return_base = l5_return_steps(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8)
fp.rule(l5_header_to_return(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8), l5_header_to_return_base, name="l5_header_to_return_base")

l5_header_to_return_recursive = And(l5_iteration_steps(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8, l5_v1_next, l5_v2_next, l5_v3_next, l5_v4_next, l5_v5_next, l5_v6_next, l5_v7_next, l5_v8_next), l5_header_to_return(l5_v1_next, l5_v2_next, l5_v3_next, l5_v4_next, l5_v5_next, l5_v6_next, l5_v7_next, l5_v8_next))
fp.rule(l5_header_to_return(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8), l5_header_to_return_recursive, name="l5_header_to_return_recursive")

# Actual exit
l5_actual_exit_rule = And(l5_entry_states(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8), l5_header_to_exit(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8, l5_v1_out, l5_v2_out, l5_v3_out, l5_v4_out, l5_v5_out, l5_v6_out, l5_v7_out, l5_v8_out))
fp.rule(l5_actual_exit(l5_v1_out, l5_v2_out, l5_v3_out, l5_v4_out, l5_v5_out, l5_v6_out, l5_v7_out, l5_v8_out), l5_actual_exit_rule, name="l5_actual_exit_rule")

# ============================================================
# Target candidate: l5 (non-terminating)
# ============================================================

l5_recurrent_set = (l5_v6 >= IntVal(0))
l5_recurrent_set_next = (l5_v6_next >= IntVal(0))

# ============================================================
# Non-termination validation
# ============================================================

l5_reachable_recurrent_set = Function("l5_reachable_recurrent_set", BoolSort())
fp.register_relation(l5_reachable_recurrent_set)
fp.rule(l5_reachable_recurrent_set(), And(l5_reachable_header_states(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8), l5_recurrent_set), name="l5_reachable_recurrent_set_rule")

l5_recurrent_guard_solver = Solver()
l5_recurrent_guard_solver.add(l5_recurrent_set, Not(l5_guard))

l5_bad_recurrent_closure = Function("l5_bad_recurrent_closure", BoolSort())
fp.register_relation(l5_bad_recurrent_closure)
fp.rule(l5_bad_recurrent_closure(), And(l5_recurrent_set, l5_iteration_steps(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8, l5_v1_next, l5_v2_next, l5_v3_next, l5_v4_next, l5_v5_next, l5_v6_next, l5_v7_next, l5_v8_next), Not(l5_recurrent_set_next)), name="l5_bad_recurrent_closure_rule")

l5_bad_recurrent_exit = Function("l5_bad_recurrent_exit", BoolSort())
fp.register_relation(l5_bad_recurrent_exit)
fp.rule(l5_bad_recurrent_exit(), And(l5_recurrent_set, l5_exit_steps(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8, l5_v1_out, l5_v2_out, l5_v3_out, l5_v4_out, l5_v5_out, l5_v6_out, l5_v7_out, l5_v8_out)), name="l5_bad_recurrent_exit_rule")

l5_bad_recurrent_return = Function("l5_bad_recurrent_return", BoolSort())
fp.register_relation(l5_bad_recurrent_return)
fp.rule(l5_bad_recurrent_return(), And(l5_recurrent_set, l5_return_steps(l5_v1, l5_v2, l5_v3, l5_v4, l5_v5, l5_v6, l5_v7, l5_v8)), name="l5_bad_recurrent_return_rule")

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

l5_recurrent_reachability_result = check_fixedpoint(
    "RECURRENT_REACHABILITY",
    l5_reachable_recurrent_set,
    sat,
    "no reachable loop-header state belongs to the recurrent set."
)

l5_recurrent_guard_result = check_solver(
    "RECURRENT_GUARD_CONTAINMENT",
    l5_recurrent_guard_solver,
    unsat,
    "a recurrent-set state can violate the loop guard."
)

l5_recurrent_closure_result = check_fixedpoint(
    "RECURRENT_CLOSURE",
    l5_bad_recurrent_closure,
    unsat,
    "a completed loop iteration can leave the recurrent set."
)

l5_recurrent_exit_result = check_fixedpoint(
    "RECURRENT_NO_NORMAL_EXIT",
    l5_bad_recurrent_exit,
    unsat,
    "a recurrent-set state can permit normal loop exit."
)

l5_recurrent_return_result = check_fixedpoint(
    "RECURRENT_NO_FUNCTION_RETURN",
    l5_bad_recurrent_return,
    unsat,
    "a recurrent-set state can permit function return."
)

RECURRENT_SET_RESULT = validation_status([
    (l5_recurrent_reachability_result, sat),
    (l5_recurrent_guard_result, unsat),
    (l5_recurrent_closure_result, unsat),
    (l5_recurrent_exit_result, unsat),
    (l5_recurrent_return_result, unsat)
])

print()
print(f'RECURRENT_SET_RESULT: "{RECURRENT_SET_RESULT}"')
