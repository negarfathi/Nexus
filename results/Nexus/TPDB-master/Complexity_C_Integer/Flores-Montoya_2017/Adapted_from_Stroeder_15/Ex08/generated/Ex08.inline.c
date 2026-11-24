extern int __VERIFIER_nondet_int(void);

int foo(int i,int up){
up = 0;
while (i > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        if (i == 1) {
            up = 1;
        }
        if (i == 10) {
            up = 0;
        }
        if (up == 1) {
            i = i+1;
        } else {
            i = i-1;
        }
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

