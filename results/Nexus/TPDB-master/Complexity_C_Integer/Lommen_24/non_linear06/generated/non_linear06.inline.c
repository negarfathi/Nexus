int non_linear06(int x1, int x2, int x3, int x4, int y1, int y2) {
  while(x4*x4 - x3*x3*x3*x3*x3 < 2*y1 - y2 && x4 != 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    int x1_ = x1;
    int x2_ = x2;
    x1 = 3*x1_ + 2*x2_;
    x2 = -5*x1_ -3*x2_;
    x4 = -2*x4;
    int y1_ = y1;
    int y2_ = y2;
    y1 = y1_ + y1_*y1_ + x3*x3;
    y2 = -4*y1_ + 2*y1_*y1_ + 3*y2_ + x3*x3;
  }
  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
