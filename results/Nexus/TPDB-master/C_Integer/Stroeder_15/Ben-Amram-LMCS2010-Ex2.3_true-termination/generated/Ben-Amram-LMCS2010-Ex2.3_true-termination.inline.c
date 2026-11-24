/*
 * Program from Ex.2.3 of
 * 2010LMCS - Ben-Amram - Size-Change Termination, Monotonicity Constraints and Ranking Functions
 *
 * Date: 12.12.2013
 * Author: heizmann@informatik.uni-freiburg.de
 *
 */

typedef enum {false, true} bool;

extern int __VERIFIER_nondet_int(void);

int main() {
    int x, y, z;
	x = __VERIFIER_nondet_int();
	y = __VERIFIER_nondet_int();
	z = __VERIFIER_nondet_int();

	while (x > 0 && y > 0 && z > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
		if (y > x) {
			y = z;
			x = __VERIFIER_nondet_int();
			z = x - 1;
		} else {
			z = z - 1;
			x = __VERIFIER_nondet_int();
			y = x - 1;
		}
	}
	{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
