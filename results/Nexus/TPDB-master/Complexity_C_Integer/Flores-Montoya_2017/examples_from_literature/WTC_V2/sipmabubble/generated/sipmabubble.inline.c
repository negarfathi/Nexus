int nondet();

void sipmabubble(int n){
  /* n >= 0 */
  //int A[100];
  int tmp;

  int i, j;

  i = n;
  while(i >= 0){ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    j = 0;
    while(j <= i-1){ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
      if(nondet() > nondet()){
	  ;
	  //tmp = A[j];
      //A[j] = A[j+1];
      //A[j+1] = tmp;
	}
      ++j;
    }
    i--;
  }
}
