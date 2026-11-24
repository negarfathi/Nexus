/*
 * Date: 2013-07-13
 * Author: leike@informatik.uni-freiburg.de
 *
 * Simple test case for the lexicographic template.
 * Has the lexicographic ranking function
 * f(x, y) = <x, y>
 *
 */

typedef enum {false, true} bool;

extern int __VERIFIER_nondet_int(void);

int main() {
	int x, y;
	while (x >= 0 && y >= 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
		y = y - 1;
		if (y < 0) {
			x = x - 1;
			y = __VERIFIER_nondet_int();
		}
	}
    { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
