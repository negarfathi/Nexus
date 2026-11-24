//taken from cBench	security_pgp_d/src/zinflate.c	inflate_stored	
//similar pattern can be found in cBench	security_pgp_d/src/zinflate.c	inflate_dynamic	

int random();

//Complexity: O(n)
void inflate_stored(int n, int k, int limit)
{
   /* unsigned n;
    unsigned w;
    register ULONG b;
    register unsigned k;
    b = bb;
    k = bk;
    w = wp;
    n = k & 7; {
	b >>= (n);*/
	k -= (n);
    //}; {
	while (k < (16)) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
	    /*if (--incnt < 0 && FillInBuf())
		return 1;*/
	    //b |= (ULONG) * inptr++ << k;
	    k += 8;
	}
    //}
    /*n = b & 0xffff; {
	b >>= (16);*/
	k -= (16);
    //}
    {
	while (k < (16)) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_0" ::: "memory"); 
	    /*if (--incnt < 0 && FillInBuf())
		return 1;*/
	    //b |= (ULONG) * inptr++ << k;
	    k += 8;
	}
    }
    if (random())//n != ((~b) & 0xffff)
	{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return; }
    {
      //b >>= (16);
      k -= (16);
    }
	while (n-- > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_3_PARENT_0" ::: "memory");  {
		while (k < limit) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_4_PARENT_3" ::: "memory");  //in original code: limit = (8)
		    /*if (--incnt < 0 && FillInBuf())
			return 1;*/
		    //b |= (ULONG) * inptr++ << k;
		    k += 8;
		}
	}
	/*slide[w++] = b;
	if (w == 8192) {
	    flush(w);
	    w = 0;
	}*/
	    {
		//b >>= (8);
		k -= (8);
	    }
	}
	/*wp = w;
	bb = b;
	bk = k;*/
	{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return; }
}

