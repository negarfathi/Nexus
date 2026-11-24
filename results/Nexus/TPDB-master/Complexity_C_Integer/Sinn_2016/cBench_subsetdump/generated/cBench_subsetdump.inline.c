//taken from cBench	office_ispell/src/dump.c	subsetdump	883

int random();

//Complexity: O(n)
void subsetdump(int limit) 
{
    int cnum;
    int rangestart;
    for (cnum = 0; cnum < limit; cnum++) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
	if (random()) {
	    for (rangestart = cnum; cnum < limit; cnum++) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
		if (random())
		    break;
	    }
	    if (random()) {
		while (rangestart < cnum)
		    { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_3_PARENT_1" ::: "memory"); rangestart++; }
	    }
	}
   }
}


