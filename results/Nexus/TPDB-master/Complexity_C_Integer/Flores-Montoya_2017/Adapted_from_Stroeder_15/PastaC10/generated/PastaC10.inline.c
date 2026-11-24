extern int __VERIFIER_nondet_int(void);

int foo(int i,int j,int r){
while (i - j >= 1) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        i = i - __VERIFIER_nondet_int();
        r = __VERIFIER_nondet_int() + 1;
        j = j + r;
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

