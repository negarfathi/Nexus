int size08(int a, int b, int c) {
  if (c < 0) {
    while(a + b*b > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        a = a + b*b*c;
        b = b - 2*c*c;
        c = c;
      }
    }
    b = b*b;
    while(b > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_0" ::: "memory"); 
      b = b - 1;
    }
    { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
