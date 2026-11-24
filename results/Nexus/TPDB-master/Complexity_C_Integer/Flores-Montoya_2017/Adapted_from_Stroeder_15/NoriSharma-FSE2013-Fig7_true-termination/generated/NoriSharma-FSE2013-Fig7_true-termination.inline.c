extern int __VERIFIER_nondet_int(void);

int foo(int a,int b,int c,int i,int j,int M,int N){
a = i;
b = j;
c = 0;
while (i<M || j<N) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    	i = i + 1;
    	j = j + 1;
    	c = c + 1;
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

