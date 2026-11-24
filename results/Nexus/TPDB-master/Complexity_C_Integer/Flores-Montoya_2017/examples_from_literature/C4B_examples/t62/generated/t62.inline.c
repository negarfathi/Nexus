
int nondet();


void t62(int l, int h) {
  if (l>= h) { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return; }
  for (;;) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    do { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory");  l++; } while (l<h && nondet()>0);
    do { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_3_PARENT_1" ::: "memory");  h--; } while (l<h && nondet()>0);
    if (l >= h) break;
  }
}

