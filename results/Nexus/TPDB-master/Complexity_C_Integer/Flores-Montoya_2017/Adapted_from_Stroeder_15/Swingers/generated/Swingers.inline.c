extern int __VERIFIER_nondet_int(void);

int foo(int bob,int samantha,int temp){
bob = 13;
samantha = 17;
while (bob + samantha < 100) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        temp = bob;
        bob = samantha;
        samantha = temp;
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
