extern int __VERIFIER_nondet_int(void);

int foo(int x,int y,int z){
if (y > 0) {
        while (x >= z) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
            z = z+y;
        }
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

