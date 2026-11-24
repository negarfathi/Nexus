int non_linear18(int x1, int x2, int x3) {
  while(x3 > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    int x1_ = x1;
    int x2_ = x2;
    x1 = x1_ + 2*x2_;
    x2 = 3*x1_ + 4*x2_;
    x3 = x3 - 1;
  }
  while(x1 > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_0" ::: "memory"); 
    x1 = x1 - 1;
  }
  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
