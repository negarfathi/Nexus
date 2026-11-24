print('===================== SEMANTIC FEEDBACK =====================')
print('TARGET_LOOP: l2')
print('CANDIDATE_KIND: non-terminating')
print()
print('RECURRENT_SET:')
print("{\n  \"op\": \"and\",\n  \"args\": [\n    {\n      \"op\": \"<\",\n      \"args\": [\n        \"l2_v4\",\n        \"l2_v4\"\n      ]\n    },\n    {\n      \"op\": \">\",\n      \"args\": [\n        \"l2_v4\",\n        0\n      ]\n    }\n  ]\n}")
print()
print('FEEDBACK:')
#!/usr/bin/env python3

print("UNSUPPORTED: \"l1: source-nested child exits outside LLVM parent through an unsummarized continuation: %65\"")
print('RECURRENT_SET_RESULT: "unknown"')
print("VALIDATION_SUMMARY_JSON:{\"loop_id\":\"l2\",\"candidate_kind\":\"non-terminating\",\"status\":\"unsupported\",\"components\":{},\"checks\":[],\"reason\":\"l1: source-nested child exits outside LLVM parent through an unsummarized continuation: %65\"}")
