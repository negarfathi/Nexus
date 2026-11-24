int nondet();

int counterex1a(int n,int b,int x,int y)
{
 
  while (x>=0 && 0<=y && y<=n) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    if (b==0) {
      y++;                      /* transition t1 */
      if (nondet()>0) b=1;        /* transition t3 */
    }
    else {
      y--;                      /* transition t2 */
      if (nondet()>0) {x--; b=0;} /* transition t4 */
    }
  }
  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

