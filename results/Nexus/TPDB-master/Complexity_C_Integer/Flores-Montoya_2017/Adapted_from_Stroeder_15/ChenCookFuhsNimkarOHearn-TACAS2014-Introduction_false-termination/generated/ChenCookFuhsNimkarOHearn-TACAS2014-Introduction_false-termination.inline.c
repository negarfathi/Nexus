extern int __VERIFIER_nondet_int(void);

int foo(int k,int i){
if (k >= 0) {
		
	} else {
		i = -1;
	}
while (i >= 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
		i = __VERIFIER_nondet_int();
	}
i = 2;
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

