extern int __VERIFIER_nondet_int(void);

int size11(int a, int b, int c, int d, int e) {
  while(e > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    e = e - 1;
    int u = __VERIFIER_nondet_int();
    if(u > 0) {
      c = a + b;
      d = b;
    } else {
      c = b;
      d = a + b;
    }
    a = c + d;
  }
  while(a > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_0" ::: "memory"); 
    a = a - 1;
  }
  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
