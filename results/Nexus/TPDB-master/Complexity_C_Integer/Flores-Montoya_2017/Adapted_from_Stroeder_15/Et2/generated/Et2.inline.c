extern int __VERIFIER_nondet_int(void);

int foo(int a,int b,int r){
while (b > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        r =  __VERIFIER_nondet_int();
        b = a - 1 - r;
        a = a - 1 - r;
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
