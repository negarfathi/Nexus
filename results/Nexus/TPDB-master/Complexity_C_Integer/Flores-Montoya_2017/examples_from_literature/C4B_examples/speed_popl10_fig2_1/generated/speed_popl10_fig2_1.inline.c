void speed_popl10_fig2_1(int x, int y, int n, int m)
{
  while (n>x) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    if (m>y)
      y = y+1;
    else
      x = x+1;
  }
}

