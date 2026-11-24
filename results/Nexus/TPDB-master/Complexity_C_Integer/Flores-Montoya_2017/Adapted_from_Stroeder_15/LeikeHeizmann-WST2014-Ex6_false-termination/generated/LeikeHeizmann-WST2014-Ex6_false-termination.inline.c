extern int __VERIFIER_nondet_int(void);

int foo(int a,int b){
while (a >= 1 && b >= 1) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
		a = 2*a;
		b = 3*b;
	}
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

