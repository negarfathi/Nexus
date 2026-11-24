extern int __VERIFIER_nondet_int(void);

int non_linear15(int x1, int x2) {
  while(x2 < x1 && x2 > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    if(__VERIFIER_nondet_int()) {
      x1 = 2*x1;
      x2 = 3*x2;
    } else {
      x1 = 2*x1;
      x2 = 4*x2;
    }
  }
  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
