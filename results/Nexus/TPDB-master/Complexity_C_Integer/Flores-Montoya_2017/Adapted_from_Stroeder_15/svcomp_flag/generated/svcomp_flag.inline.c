extern int __VERIFIER_nondet_int(void);

int foo(int flag,int c,int x,int y){
flag = 1;
c = 0;
while (flag != 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        if (x >= y) {
            flag = 0;
        }
        x = x + 1;
        c = c + 1;
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

