//taken from SPEC CPU2006	hmmer/src/weight.c SingleLinkCluster

int nondet();

//O(n^2)
void SingleLinkCluster(unsigned int n) {
  int a = n;
  int b = 0;
  while(a > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    a--;
    b++;
    while(b > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
      b--;
      for(int i = n - 1; i > 0; i--)
        { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_3_PARENT_2" ::: "memory"); if(a > 0 && nondet()) {
          a--;
          b++;
        } }
    }
  } 
}

