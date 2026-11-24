extern int __VERIFIER_nondet_int(void);

int foo(int i,int j){
while (1) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        if (i < j) {
            i = i+4;
        } else {
            j = j+1;
            i = i+2;
        }
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

