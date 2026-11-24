extern int __VERIFIER_nondet_int(void);

int foo(int i){
while (i*i > 9) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        if (i < 0) {
            i = i-1;
        } else {
            i = i+1;
        }
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

