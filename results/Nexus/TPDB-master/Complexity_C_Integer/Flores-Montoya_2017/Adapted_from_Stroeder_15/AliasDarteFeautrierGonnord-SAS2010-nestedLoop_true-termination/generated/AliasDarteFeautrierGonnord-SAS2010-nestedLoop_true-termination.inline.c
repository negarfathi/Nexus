extern int __VERIFIER_nondet_int(void);

int foo(int i,int j,int k,int m,int n,int N){
if (0 <= n && 0 <= m && 0 <= N) {
		i = 0;
		while (i < n) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
			j = 0;
			while (j < m) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
				j = j + 1;
				k = i;
				while (k < N) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_3_PARENT_2" ::: "memory"); 
					k = k + 1;
                }
				i = k;
			}
			i = i + 1;
		}
	}
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

