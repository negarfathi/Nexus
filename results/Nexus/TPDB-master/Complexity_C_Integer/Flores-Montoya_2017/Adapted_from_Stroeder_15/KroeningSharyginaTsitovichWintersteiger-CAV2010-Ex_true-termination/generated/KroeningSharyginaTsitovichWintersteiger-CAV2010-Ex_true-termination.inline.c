extern int __VERIFIER_nondet_int(void);

int foo(int i){
while (i < 255) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
		if (__VERIFIER_nondet_int() != 0) {
			i = i + 1;
		} else {
			i = i + 2;
		}
	}
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

