/*
 * Date: 2012-12-14
 * Author: Jan Leike and heizmann@informatik.uni-freiburg.de
 *
 * Has linear ranking function f(x)=x with supporting invariant
 * (y>=100 /\ z=1) \/ (y>=99 /\ z=1).
 * However, there is no linear supporting invariant for this ranking function.
 * 
 * Has a three phase ranking function.
 */

typedef enum {false, true} bool;

extern int __VERIFIER_nondet_int(void);

int main()
{
    int x, y, z;
	x = __VERIFIER_nondet_int();
	y = 100;
	z = 1;
	while (x >= 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
		x = x - y;
		y = y - z;
		z = -z;
	}
	{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
