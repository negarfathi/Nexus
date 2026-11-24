void t19(int i, int k)
{
  while (i > 100)
    { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); i--; }
  i=i+k+50;
  while (i >= 0)
    { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_0" ::: "memory"); i--; }
}

