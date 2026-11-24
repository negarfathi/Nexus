int non_linear19(int x1, int x2, int x3) {
  while(x2 < x1 && x2 > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    x1 = 2*x1;
    x2 = 3*x2;
    x3 = x3*x3;
  }
  while(0 < x3) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_0" ::: "memory"); 
    x3 = x3 - 1;
  }
  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
