extern int __VERIFIER_nondet_int(void);

int foo(int a,int x,int max){
if (max > 0) {
		a = 0;
		x = 1;
		while (x <= max) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
			if (__VERIFIER_nondet_int() != 0) {
				a = a + 1;
			} else {
				a = a - 1;
            }
			x = x + 1;
		}
	}
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

