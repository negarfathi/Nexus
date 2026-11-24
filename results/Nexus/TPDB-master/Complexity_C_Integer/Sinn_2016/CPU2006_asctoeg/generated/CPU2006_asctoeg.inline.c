//taken from SPEC CPU2006	gcc/src/real.c 	asctoeg

int random();

//O(n^2)
void asctoeg(int s) {
  int k = s;
  while(k > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
	  int sp = 0;
	  while (sp < s && random())
	    { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); ++sp; }
	  --sp;
	  while (sp > 0 && random())
	    { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_3_PARENT_1" ::: "memory"); sp--; }
    k--;
  }
}

