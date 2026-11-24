

void speedpldi3(int m, int n){
  int i, j;
  if(m <= 0) { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return; }
  if(n <= m) { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return; }
  i=0;
  j=0;
  while(i<n)
    { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); if(j<m) ++j;
    else {
      j = 0;
      ++i;
    } }
}
