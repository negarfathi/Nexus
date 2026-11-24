extern int __VERIFIER_nondet_int(void);

int foo(int x,int i,int n,int m){
while (x < n) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
		i = i + 1;
		x = x + 1;
	}
while (x < m) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_0" ::: "memory"); 
		i = i + 1;
		x = x + 1;
	}
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

