//taken from cBench/office_ghostscript/src/shcgen.c

int random();

void hc_compute(int num_values) {
    for (int i = num_values; i > 0;) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
	int j = i;
	--j;// int len = nodes[--j].code_length;
	while (j > 0 && random())
	    { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); --j; }
	//qsort(&nodes[j], i - j, sizeof(count_node), compare_values);
	for(int x = i - j; x > 0; x --)//quadratic loop as substitute for qsort 
		{ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_3_PARENT_1" ::: "memory"); for(int y = x; y > 0 && random(); y--){ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_4_PARENT_3" ::: "memory"); ; } } 
	i = j;
    }
}

