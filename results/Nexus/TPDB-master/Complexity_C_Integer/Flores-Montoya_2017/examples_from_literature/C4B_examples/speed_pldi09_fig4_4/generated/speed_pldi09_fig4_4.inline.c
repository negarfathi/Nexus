

void peed_pldi09_fig4_4(int n, int m)
{
  int i=n;

  if(0 >= m) { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return; }

  while (i > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    if (i < m)
      i=i-1;
    else
      i=i-m;
  }
}
