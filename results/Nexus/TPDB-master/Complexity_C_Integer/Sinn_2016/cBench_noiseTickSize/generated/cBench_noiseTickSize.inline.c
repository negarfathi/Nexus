int nondet();

void noiseTickSize(int DELTAS)
{
    int i;
    int j;

    /*unsigned deltas[DELTAS];
    unsigned t;
    struct timeval tv_base, tv_old, tv_new;*/

    i = j = 0;
    //gettimeofday(&tv_base, 0);
    //tv_old = tv_base;
    do { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
		//gettimeofday(&tv_new, 0);
		if (nondet()) { //tv_new.tv_usec > tv_old.tv_usec + 2
			i++;
			//tv_base = tv_new;
			j = 0;
		}

		//tv_old = tv_new;

		/*
		 * If we are forever getting <= 2 us, then just assume
		 * it's 2 us.
		 */
		if (j++ > 10000)
			{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_1_IDS_1" ::: "memory"); return; }// 2;
	} while (i < DELTAS);

    //t = deltas[DELTAS / 2];	/* Median */

//	return t;
}
