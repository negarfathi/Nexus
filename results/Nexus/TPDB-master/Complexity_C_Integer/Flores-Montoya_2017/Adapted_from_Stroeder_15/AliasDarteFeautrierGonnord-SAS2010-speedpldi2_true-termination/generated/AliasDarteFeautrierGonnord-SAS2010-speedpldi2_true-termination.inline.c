extern int __VERIFIER_nondet_int(void);

int foo(int m,int n,int v1,int v2){
if (n >= 0 && m > 0) {
		v1 = n;
		v2 = 0;
		while (v1 > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
			if (v2 < m) {
				v2 = v2 + 1;
				v1 = v1 - 1;
			} else {
				v2 = 0;
			}
		}
	}
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

