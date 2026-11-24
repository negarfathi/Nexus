void speed_popl10_fig2_2(int x, int z, int n)
{
  while (x<n) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    if (z>x)
      x=x+1;
    else
      z=z+1;
  }
}
