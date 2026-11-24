int twn18(int a, int b, int c, int d, int e) {
  while(b*b > 1 && a*c + 2*a > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
      a = a;
      int b1 = b;
      int c1 = c;
      b = 3*b1 - 4*c1;
      c = 4*b1 - 3*c1;
      d = 5*d;
      e = 5*e - a*a;
  }

  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
