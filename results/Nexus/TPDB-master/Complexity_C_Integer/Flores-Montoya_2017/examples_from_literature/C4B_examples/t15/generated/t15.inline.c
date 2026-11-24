

void t15(int x, int y)
{
  int z;

  if(y < 0) { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return; }

  while (x>y) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    x-=y+1;
    for (z=y; z>0; z--)
      /* nothing */{ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); ; }
  }
}

