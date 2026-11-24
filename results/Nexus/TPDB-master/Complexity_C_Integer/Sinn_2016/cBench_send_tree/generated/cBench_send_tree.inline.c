//taken from cBench security_pgp_d/src/ztrees.c	send_tree

int random();

//Complexity: O(n)
void send_tree(int max_code, int max_count, int min_count)
{
    int n;
    int count = 0;
    for (n = 0; n <= max_code; n++) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
	if (++count < max_count && random()) {
	    //continue;
	} else {
	  if (count < min_count) {
	    do { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
	    } while (--count > 0); //original code: --count != 0
	  } else if (random()) {
	    if (random()) {
		count--;
	    };
	  }
	  count = 0;
    }
  }
}

