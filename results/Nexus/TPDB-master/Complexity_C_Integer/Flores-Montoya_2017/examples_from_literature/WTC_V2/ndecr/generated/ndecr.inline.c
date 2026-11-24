

/*ndecr == decr presque*/
int ndecr (int n)
{


  int i=n-1;

  while(i>1) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); i--;}


  { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }

}
