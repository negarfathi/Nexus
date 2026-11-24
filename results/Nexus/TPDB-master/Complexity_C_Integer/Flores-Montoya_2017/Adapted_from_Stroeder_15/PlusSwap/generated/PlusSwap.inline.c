extern int __VERIFIER_nondet_int(void);

int foo(int x,int y,int z,int res){
res = 0;
while (y > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        z = x;
        x = y-1;
        y = z;
        res = res+1;
    }
res = res + x;
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

