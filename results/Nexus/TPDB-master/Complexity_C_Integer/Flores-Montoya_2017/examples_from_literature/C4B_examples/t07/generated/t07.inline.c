

void t07(int x, int y)
{
  while (x>0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    x=x-1;
    y=y+2;
  }
  while (y>0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_0" ::: "memory"); 
    y=y-1;
  }
  while (y>0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_3_PARENT_0" ::: "memory"); 
    y=y-1;
  }
}

