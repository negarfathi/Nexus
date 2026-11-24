extern int __VERIFIER_nondet_int(void);

void non_linear14(int x1, int x2, int x3, int x4, int y1, int y2) {
  int u = __VERIFIER_nondet_int();
  int v = __VERIFIER_nondet_int();

  x1 = u;
  while (1) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    if (1 <= x1 && x1 <= 3 && v == 0) {
      x1 = x1 + 1;
      v = __VERIFIER_nondet_int();
    } else if (x2 > 1 && v == 1) {
      x2 = x2 - 1;
      v = __VERIFIER_nondet_int();
    } else {
      while(x4*x4 - x3*x3*x3*x3*x3 < 2*y1 - y2 && x4 != 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
        x4 = -2*x4;
        int y1_ = y1;
        int y2_ = y2;
        y1 = y1_ + y1_*y1_ + x3*x3;
        y2 = -4*y1_ + 2*y1_*y1_ + 3*y2_ + x3*x3;
      }
      break;
    }
  }
}
