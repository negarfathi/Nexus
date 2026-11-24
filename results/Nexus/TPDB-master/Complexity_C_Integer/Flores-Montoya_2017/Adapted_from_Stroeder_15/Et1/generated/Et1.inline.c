extern int __VERIFIER_nondet_int(void);

int foo(int a,int b){
a = - __VERIFIER_nondet_int();
b = - __VERIFIER_nondet_int();
while (a > b) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        b = b + a;
        a = a + 1;
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

