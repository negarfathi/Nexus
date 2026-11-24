extern int __VERIFIER_nondet_int(void);

int foo(int a,int b,int am,int bm){
am = a;
bm = b;
while (am != bm) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        if (am > bm) {
            bm = bm+b;
        } else {
            am = am+a;
        }
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

