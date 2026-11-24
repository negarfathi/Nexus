//taken from security_pgp_d/src/random.c 	cryptRandWriteFile	1220

//Complexity: O(n)
void cryptRandWriteFile(int bytes) {
    while (bytes > 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
	int len = (bytes < 256) ? bytes : 256;
	for (int i = 0; i < len; i++){ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); ; }
	bytes -= len;
    }
}

