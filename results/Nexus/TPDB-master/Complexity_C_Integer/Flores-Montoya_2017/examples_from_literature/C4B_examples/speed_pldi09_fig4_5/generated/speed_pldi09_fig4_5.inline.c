

void peed_pldi09_fig4_5(int n, int m, int dir)
{
  int i;

  if (0 >= m) { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return; }
  if (m >= n) { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return; }

  i = m;

  while (0 < i && i < n) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    if (dir == 1)
      i++;
    else
      i--;
  }
}
