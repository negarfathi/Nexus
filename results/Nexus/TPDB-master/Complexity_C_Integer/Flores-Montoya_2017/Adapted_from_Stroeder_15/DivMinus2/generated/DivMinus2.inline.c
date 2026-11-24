extern int __VERIFIER_nondet_int(void);

int foo(int x,int y,int ytmp,int res){
res = 0;
while (x >= y && y > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        ytmp = y;
        while (ytmp != 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
            if (ytmp > 0)  {
                ytmp = ytmp - 1;
                x = x - 1;
            } else  {
                ytmp = ytmp + 1;
                x = x + 1;
            }
        }
        res = res + 1;
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
