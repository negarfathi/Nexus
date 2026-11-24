extern int __VERIFIER_nondet_int(void);

int foo(int i,int j){
i = 0;
j = 3;
while (i < 10) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        while (j < 12) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
            j = j-1;
            j = j+2;
        }
        i = i+1;
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
