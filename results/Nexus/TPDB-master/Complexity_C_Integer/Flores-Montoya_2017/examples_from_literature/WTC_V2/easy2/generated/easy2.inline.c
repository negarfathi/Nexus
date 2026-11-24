

int easy2(int z) {
  int x=12;
  int y=0;
  while (z>0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    x=x+1;
    y=y-1;
    z=z-1;
}
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
