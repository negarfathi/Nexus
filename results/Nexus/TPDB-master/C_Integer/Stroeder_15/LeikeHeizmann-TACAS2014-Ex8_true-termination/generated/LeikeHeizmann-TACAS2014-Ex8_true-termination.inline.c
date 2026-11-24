/*
 * Program from Example 8 of
 * 2014TACAS - Leike, Heizmann - Ranking Templates for Linear Loops
 *
 * Date: 2014-06-29
 * Author: Jan Leike
 */

typedef enum {false, true} bool;

extern int __VERIFIER_nondet_int(void);

int main() {
    int q, y;
	q = __VERIFIER_nondet_int();
	y = __VERIFIER_nondet_int();
	while (q > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
		if (y > 0) {
			y = 0;
			q = __VERIFIER_nondet_int();
		} else {
			y = y - 1;
			q = q - 1;
		}
	}
	{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
