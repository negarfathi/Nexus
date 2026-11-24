extern int __VERIFIER_nondet_int(void);

int foo(int c,int x,int y,int z){
c = 0;
while ((x == y) && (x > z)) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        while (y > z) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
            x = x - 1;
            y = y - 1;
            c = c + 1;
        }
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

