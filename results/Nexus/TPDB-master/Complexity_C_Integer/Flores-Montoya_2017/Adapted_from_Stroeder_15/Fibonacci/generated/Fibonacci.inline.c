extern int __VERIFIER_nondet_int(void);

int foo(int n,int i,int j,int t){
i = 0;
j = 1;
t = 0;
while (j != n) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        t = j+i;
        i = j;
        j = t;
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

