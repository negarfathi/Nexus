extern int __VERIFIER_nondet_int(void);

int non_linear11(int x1, int x2, int x3) {
  while(x1 > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    if(__VERIFIER_nondet_int()) {
        x1 = x1 - 1;
        x3 = x3 + x2*x2;
    } else {
        x1 = x1 - 1;
        x3 = x3 + x2*x2 + 1;
    }
  }
  while(x3 > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_0" ::: "memory"); 
    x3 = x3 - 1;
  }
  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
