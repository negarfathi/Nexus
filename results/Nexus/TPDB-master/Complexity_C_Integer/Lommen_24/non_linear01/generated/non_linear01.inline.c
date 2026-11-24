int non_linear01(int x1, int x2, int x3, int x4, int x5) {
  while(x4*x4 - x3*x3*x3*x3*x3 < x5 && x4 != 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    int x1_ = x1;
    int x2_ = x2;
    x1 = 3*x1_ + 2*x2_;
    x2 = -5*x1_ -3*x2_;
    x4 = -2*x4;
    x5 = 3*x5 + x3*x3;
  }
  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
