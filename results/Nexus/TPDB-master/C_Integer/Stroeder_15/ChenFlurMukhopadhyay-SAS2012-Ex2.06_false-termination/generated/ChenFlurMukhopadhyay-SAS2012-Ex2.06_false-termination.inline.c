/*
 * Date: 2014-06-08
 * Author: leike@informatik.uni-freiburg.de
 *
 *
 * This is Example 2.6 from the test suit used in
 *
 * Termination Proofs for Linear Simple Loops.
 * Hong Yi Chen, Shaked Flur, and Supratik Mukhopadhyay.
 * SAS 2012.
 * 
 * The authors of the paper claim that this program is terminating, however
 * the program is nonterminating (e.g., initial state x=1 and y=1).
 *
 * The test suite is available at the following URL.
 * https://tigerbytes2.lsu.edu/users/hchen11/lsl/LSL_benchmark.txt
 *
 * Comment: terminating, non-linear
 */

typedef enum {false, true} bool;

extern int __VERIFIER_nondet_int(void);

int main() {
    int x, y, oldx;
    x = __VERIFIER_nondet_int();
    y = __VERIFIER_nondet_int();
    while (4*x + y > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        oldx = x;
        x = -2*oldx + 4*y;
        y = 4*oldx;
    }
    { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
