/*
 * Program used in the experimental evaluation of the following paper.
 * 2010SAS - Alias,Darte,Feautrier,Gonnord, Multi-dimensional Rankings, Program Termination, and Complexity Bounds of Flowchart Programs
 *
 * Date: 2014
 * Author: Caterina Urban
 */

typedef enum {false, true} bool;

extern int __VERIFIER_nondet_int(void);

int main() {
    int i, j, k, m, n, N;
	i = __VERIFIER_nondet_int();
	j = __VERIFIER_nondet_int();
	k = __VERIFIER_nondet_int();
	n = __VERIFIER_nondet_int();
	m = __VERIFIER_nondet_int();
	N = __VERIFIER_nondet_int();
	if (0 <= n && 0 <= m && 0 <= N) {
		i = 0;
		while (i < n) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
			j = 0;
			while (j < m) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
				j = j + 1;
				k = i;
				while (k < N) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_3_PARENT_2" ::: "memory"); 
					k = k + 1;
                }
				i = k;
			}
			i = i + 1;
		}
	}
	{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
