extern int __VERIFIER_nondet_int(void);

int foo(int a,int b){
a = 1;
b = 2;
while (a + b < 5) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        a = a - b;
        b = a + b;
        a = b - a;
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

