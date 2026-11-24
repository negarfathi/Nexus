extern int __VERIFIER_nondet_int(void);

int non_linear16(int x1, int x2, int y1, int y2) {
  while(x2 < x1 && x2 > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    x1 = 2*x1;
    x2 = 3*x2;
  }
  int t = __VERIFIER_nondet_int();
  while(y1 > 0 && t > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_0" ::: "memory"); 
    y1 = y1 + y2;
    y2 = y2 - t;
    t = __VERIFIER_nondet_int();
  }
  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
