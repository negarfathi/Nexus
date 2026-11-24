//taken from SPEC CPU2006	perlbench/src/toke.c 	Perl_scan_vstring

int nondet();

//O(n)
void
Perl_scan_vstring(int s, int PL_bufend)
{
    int pos = s;
    int start = s;
    if (nondet()) pos++;  /* get past 'v' */
    while (pos < PL_bufend && nondet())
	{ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); pos++; }

    if (nondet()) {

	if (nondet()) s++;  /* get past 'v' */

	for (;;) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_0" ::: "memory"); 
	    {
		int end = pos;
		while (--end >= s) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_3_PARENT_2" ::: "memory"); 
		}
	    }
	    if (pos + 1 < PL_bufend && nondet())
		 s = ++pos;
	    else {
		 s = pos;
		 break;
	    }
	    while (pos < PL_bufend && nondet())
		 { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_4_PARENT_2" ::: "memory"); pos++; }
	}
    }
}

