extern int __VERIFIER_nondet_int(void);

int foo(int x,int y,int oldy){
while (x > 0 && y <= -oldy) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        x = y;
        oldy = y;
        y = __VERIFIER_nondet_int();
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

