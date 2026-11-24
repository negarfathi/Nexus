extern int __VERIFIER_nondet_int(void);

int non_linear20(int x1, int x2) {
  int t = __VERIFIER_nondet_int();
  while(x2 < x1 && x2 > 0 && t >= 3) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    x1 = 2*x1;
    x2 = t*x2;
    int t = __VERIFIER_nondet_int();
  }
  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
