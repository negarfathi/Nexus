int non_linear03(int x1, int x2, int x3) {
  while(x3*x3 < x1*x2 && x3 != 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    x1 = 2*x1;
    x2 = 3*x2;
    x3 = 4*x3;
  }
  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
