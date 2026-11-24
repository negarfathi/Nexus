/*
 * Date: 2013-12-20
 * Author: leike@informatik.uni-freiburg.de
 *
 * An example tailored to the parallel ranking template.
 *
 * A ranking function is
 *
 * f(x, y) = max{x, 0} + max{y, 0}.
 *
 */

typedef enum {false, true} bool;

extern int __VERIFIER_nondet_int(void);

int main()
{
    int x, y;
	x = __VERIFIER_nondet_int();
	y = __VERIFIER_nondet_int();
	while (x >= 0 || y >= 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
		if (x >= 0) {
			x = x - 1;
		} else {
			y = y - 1;
		}
	}
	{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
