extern int __VERIFIER_nondet_int(void);

int foo(int i,int j,int c){
c = 0;
i = 0;
while (i < 100) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        c = c + 1;
        i = i + 1;
    }
j = 5;
while (j < 21) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_0" ::: "memory"); 
        c = c + 1;
        j = j + 3;
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

