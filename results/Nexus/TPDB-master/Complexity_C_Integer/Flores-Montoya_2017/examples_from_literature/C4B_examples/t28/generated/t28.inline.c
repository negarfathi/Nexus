void t28(int x, int y)
{
  while (x > y) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    x--;
    x+=1000;
    y+=1000;
  }

  while (y>0)
    { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_0" ::: "memory"); y--; }
  while (x<0)
    { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_3_PARENT_0" ::: "memory"); x++; }
}

