extern int __VERIFIER_nondet_int(void);

int foo(int i,int m,int n){
if (m > 0 && n > m) {
		i = n;
		while (i > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
			if (i < m) {
				i = i - 1;
			} else {
				i = i - m;
            }
		}
	}
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

