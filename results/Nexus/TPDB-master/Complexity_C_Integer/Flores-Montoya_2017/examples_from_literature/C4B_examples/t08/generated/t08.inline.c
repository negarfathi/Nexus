void t08(int y, int z)
{
  while (z>y) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    y=y+1;
  }
  while (y>2) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_0" ::: "memory"); 
    y=y-3;
  }
}

