extern int __VERIFIER_nondet_int(void);

int foo(int x,int xtmp,int res,int restmp){
res = 0;
while (x > 1) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        xtmp = x;
        restmp = 0;
        
        while (xtmp > 1) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
            xtmp = xtmp-2;
            restmp = restmp+1;
        }
        
        x = xtmp;
        res = res+1;
        
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

