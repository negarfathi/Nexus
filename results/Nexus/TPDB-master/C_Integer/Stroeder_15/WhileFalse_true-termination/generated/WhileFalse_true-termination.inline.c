/*
 * Date: 2012-03-19
 * Author: leike@informatik.uni-freiburg.de
 *
 * The loop is equivalent to false,
 * f(x) = 0 is a ranking function.
 */
typedef enum {false, true} bool;

extern int __VERIFIER_nondet_int(void);

int main()
{
	while (false) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
	}
	{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
