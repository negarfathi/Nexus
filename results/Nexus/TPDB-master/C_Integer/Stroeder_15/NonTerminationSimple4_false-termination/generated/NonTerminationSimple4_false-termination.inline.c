/*
 * Date: 2014-06-26
 * Author: leike@informatik.uni-freiburg.de
 *
 * Does not terminate for y >= 5.
 */

typedef enum {false, true} bool;

extern int __VERIFIER_nondet_int(void);

int main()
{
    int x, y;
	x = __VERIFIER_nondet_int();
	y = __VERIFIER_nondet_int();
	if (y >= 5) {
	    while (x >= 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
		    y = y - 1;
    	}
    }
	{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
