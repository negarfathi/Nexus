int size03(int a, int b, int c, int d) {
  while(a > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    a = a - 1;
    int b_ = b;
    int c_ = c;
    b = 3*b_ + 2*c_;
    c = -5*b_ -3*c_;
    d = a*a + d;
  }
  while(d > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_0" ::: "memory"); 
    d = d - 1;
  }
  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
