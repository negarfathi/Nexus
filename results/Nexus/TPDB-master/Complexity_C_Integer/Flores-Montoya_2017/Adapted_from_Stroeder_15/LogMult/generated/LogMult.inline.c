extern int __VERIFIER_nondet_int(void);

int foo(int x,int y,int res){
y = 2;
res = 1;
if (x < 0 || y < 1) { }
    else {
        while (x > y) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
            y = y*y;
            res = 2*res;
        }
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

