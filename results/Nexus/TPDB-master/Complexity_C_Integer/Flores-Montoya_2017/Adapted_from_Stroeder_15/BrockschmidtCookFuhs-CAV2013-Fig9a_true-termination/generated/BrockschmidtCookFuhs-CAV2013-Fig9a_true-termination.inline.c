extern int __VERIFIER_nondet_int(void);

int foo(int k,int i,int j,int n){
if (k >= 1) {
		i = 0;
		while (i < n) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
			j = 0;
			while (j <= i) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
				j = j + k;
			}
			i = i + 1;
		}
	}
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

