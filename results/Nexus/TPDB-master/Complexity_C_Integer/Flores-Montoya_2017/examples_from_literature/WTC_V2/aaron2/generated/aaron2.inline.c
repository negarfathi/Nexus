int nondet();

int aaron2(int tx,int x,int y) {

  if (tx>=0) {
    while (x>=y) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
      if (tx<0) { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_1_IDS_1" ::: "memory"); return 0; }
      if (nondet()>0) 
	{
	  x=x-1-tx;
	}
      else
	{
	  y=y+1+tx;
	}
    }
  }
  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
