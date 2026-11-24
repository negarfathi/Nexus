extern int __VERIFIER_nondet_int(void);

int foo(int x,int y,int z,int n){
while (x + y >= 0 && x <= n) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        x = 2*x + y;
        y = z;
        z = z;
        z = z + 1;
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

