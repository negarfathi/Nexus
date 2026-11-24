int size13(int a, int b, int c, int d) {
  int t1 = a;
  int t2 = 0;
  int t3 = 0;
  while(t1 > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    t1 = t1 - 1;
    t2 = b + c;
    t3 = t3 + t1*t1;
    while(t2 > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
      t2 = t2 - 1;
      c = a;
      b = d;
    }
    d = b;
  }
  while(t3 > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_3_PARENT_0" ::: "memory"); 
    t3 = t3 - 1;
  }
  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
