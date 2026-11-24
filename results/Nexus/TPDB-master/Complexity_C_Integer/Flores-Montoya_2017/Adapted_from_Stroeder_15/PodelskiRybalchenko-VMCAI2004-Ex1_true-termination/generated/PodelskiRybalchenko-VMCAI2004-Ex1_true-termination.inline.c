extern int __VERIFIER_nondet_int(void);

int foo(int i,int j,int nondetNat,int nondetPos){
while (i - j >= 1) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        nondetNat = __VERIFIER_nondet_int();
        if (nondetNat < 0) {
            nondetNat = -nondetNat;
        }
		i = i - nondetNat;
		nondetPos = __VERIFIER_nondet_int();
        if (nondetPos < 0) {
            nondetPos = -nondetPos;
        }
        nondetPos = nondetPos + 1;
		j = j + nondetPos;
	}
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

