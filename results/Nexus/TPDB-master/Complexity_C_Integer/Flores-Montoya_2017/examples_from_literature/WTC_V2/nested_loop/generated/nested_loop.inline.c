int nondet();

void nested_loop(int n, int m, int N){
  int i, j, k;
  if(0<=n && 0<=m && 0<=N){
    i = 0;
    while(i<n && nondet()>0){ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
      j = 0;
      while(j<m && nondet()>0){ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
        j += 1;
        k = i;
        while(k<N && nondet()>0)
          { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_3_PARENT_2" ::: "memory"); k += 1; }
        i = k;
      }
      ++i;
    }
  }
}
