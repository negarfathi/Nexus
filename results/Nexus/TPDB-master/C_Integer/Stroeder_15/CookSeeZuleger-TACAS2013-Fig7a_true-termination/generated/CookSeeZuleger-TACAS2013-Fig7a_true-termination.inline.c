//#terminating
/*
 * Program from Fig.7a of
 * 2013TACAS - Cook,See,Zuleger - Ramsey vs. Lexicographic Termination Proving
 *
 * Date: 9.6.2013
 * Author: heizmann@informatik.uni-freiburg.de
 *
 */

typedef enum {false, true} bool;

extern int __VERIFIER_nondet_int(void);

int main() {
    int x, y, d;
	x = __VERIFIER_nondet_int();
	y = __VERIFIER_nondet_int();
	d = __VERIFIER_nondet_int();
    while (x>0 && y>0 && d>0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        if (__VERIFIER_nondet_int() != 0) {
            x = x - 1;
            d = __VERIFIER_nondet_int();
        } else {
            x = __VERIFIER_nondet_int();
            y = y - 1;
            d = d - 1;
        }
    }
    { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
