extern int __VERIFIER_nondet_int(void);

int non_linear12(int x1, int x2, int x3, int x4) {
  while(x4 > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    if(__VERIFIER_nondet_int()) {
        int x1_ = x1;
        int x2_ = x2;
        x1 = 3*x1_ + 2*x2_ + x3*x3;
        x2 = -5*x1_ -3*x2_;
        x4 = x4 - 1;
    } else {
        int x1_ = x1;
        int x2_ = x2;
        x1 = 3*x1_ + 2*x2_ + x3*x3;
        x2 = -5*x1_ -3*x2_;
        x4 = x4 - 1;
    }
  }
  x4 = x1;
  while(x4 > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_0" ::: "memory"); 
    x4 = x4 - 1;
  }
  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
