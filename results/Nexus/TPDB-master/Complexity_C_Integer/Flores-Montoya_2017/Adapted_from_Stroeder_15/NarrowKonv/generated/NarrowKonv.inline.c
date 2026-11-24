extern int __VERIFIER_nondet_int(void);

int foo(int i,int range){
range = 20;
while (0 <= i && i <= range) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        if (!(0 == i && i == range)) {
            if (i == range) {
                i = 0;
                range = range-1;
            } else {
                i = i+1;
            }
        }
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

