void t27(int n, int y)
{
  while (n<0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    n++;
    y+=1000;
    while (y>=100)
      { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); y-=100; }
  }
}

