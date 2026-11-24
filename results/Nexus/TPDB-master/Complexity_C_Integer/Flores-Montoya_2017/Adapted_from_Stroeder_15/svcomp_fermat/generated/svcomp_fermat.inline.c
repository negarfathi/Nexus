extern int __VERIFIER_nondet_int(void);

int foo(int MAX,int a,int b,int c){
MAX = 1000;
a = 1;
b = 1;
c = 1;
while (((a*a*a) != ((b*b*b)+(c*c*c))) && c <= MAX) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        a = a + 1;
        if (a>MAX) {
            a = 1;
            b = b + 1;
        }
        if (b>MAX) {
            b = 1;
            c = c + 1;
        }
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

