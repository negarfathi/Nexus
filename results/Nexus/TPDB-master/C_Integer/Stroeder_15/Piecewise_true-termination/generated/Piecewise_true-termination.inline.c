/*
 * Date: 08.10.2013
 * Author: leike@informatik.uni-freiburg.de
 *
 * An example tailored to the piecewise ranking template.
 *
 * A ranking function is
 *
 * f(p, q) = min(p, q).
 *
 */

typedef enum {false, true} bool;

extern int __VERIFIER_nondet_int(void);

int main()
{
    int p, q;
	q = __VERIFIER_nondet_int();
	p = __VERIFIER_nondet_int();
	while (q > 0 && p > 0 && p != q) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
		if (q < p) {
			q = q - 1;
			p = __VERIFIER_nondet_int();
		} else {if (p < q) {
			p = p - 1;
			q = __VERIFIER_nondet_int();
		}}
	}
	{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
