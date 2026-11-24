/*
 * Program from Fig.1b of
 * 2008CAV - Gulavani,Gulwani - A Numerical Abstract Domain Based on Expression Abstraction and Max Operator with Application in Timing Analysis
 *
 * Date: 2014
 * Author: Caterina Urban
 */

typedef enum {false, true} bool;

extern int __VERIFIER_nondet_int(void);

int main() {
    int x, i, n, m;
	x = __VERIFIER_nondet_int();
	i = __VERIFIER_nondet_int();
	n = __VERIFIER_nondet_int();
	m = __VERIFIER_nondet_int();
	while (x < n) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
		i = i + 1;
		x = x + 1;
	}
	while (x < m) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_0" ::: "memory"); 
		i = i + 1;
		x = x + 1;
	}
	{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
