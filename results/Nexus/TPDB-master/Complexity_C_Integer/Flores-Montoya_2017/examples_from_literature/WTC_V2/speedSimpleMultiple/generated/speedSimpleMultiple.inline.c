

int speedSimpleMultiple(int n,int m)
{
  int x,y;
  x=0; y=0;
  while (x<n)
    { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
      if (y<m) y++ ; else x++;  
    }
  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}



