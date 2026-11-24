extern int __VERIFIER_nondet_int(void);

int foo(int n,int sum){
sum = 0;
while (n != 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        sum = sum + n;
        n = n - 1;
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

