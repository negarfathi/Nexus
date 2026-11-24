/*
 * gcd program (terminating) based on 
 * (Dershowitz, Lindenstrauss, Sagiv and Serebrenik, 2001)
 *
 * Date: 15.12.2013
 * Author: Amir Ben-Amram, amirben@cs.mta.ac.il
 *
 */
typedef enum {false, true} bool;

extern int __VERIFIER_nondet_int(void);

int main()
{
	int r, x, y;

	x = __VERIFIER_nondet_int();
	y = __VERIFIER_nondet_int();

	if (x<0) {x = -x;}
	if (y<0) {y = -y;}
	while (y>0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
		/*  the next statements compute  r = mod(x,y)   */
		r = x;
		while (r>=y) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
			r = r-y;
        }
		/* end of inlined mod */
		x = y;
		y = r;
	}
    { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
