extern int __VERIFIER_nondet_int(void);

int foo(int a,int b,int c,int r){
while ( (b - c >= 1) && (a == c)) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        r = __VERIFIER_nondet_int();
        b = 10;
        c = c + 1 + r;
        a = c;
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

