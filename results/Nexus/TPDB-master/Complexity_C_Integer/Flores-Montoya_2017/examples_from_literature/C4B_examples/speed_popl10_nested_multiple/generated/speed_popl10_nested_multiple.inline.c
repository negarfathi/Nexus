int nondet();

void speed_popl10_nested_multiple(int x, int n, int y, int m)
{
  while (x<n) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    while (y<m) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
      if (nondet()>0)
        break;
      y=y+1;
    }
    x=x+1;
  }
}
