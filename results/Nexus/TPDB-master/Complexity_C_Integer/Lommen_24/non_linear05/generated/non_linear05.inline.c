int non_linear05(int x1, int x2) {
  while(3*x1 < 2*x2 && x2 < 2*x1) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    int x1_ = x1;
    int x2_ = x2;
    x1 = 4*x1_ - x2_;
    x2 = 2*x1_ + x2_;
  }
  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
