int nondet();

void Loopus2014_ex2(int m){
int i=m, n = 0;   //stack = emptyStack();
	while (i > 0){ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
	i--;
	if (nondet()>0)  //push
		n++;        //stack.push(element);
	else    //popMany
	while (n > 0 && nondet()>0)
		{ __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); n--; }    //element = stack.pop();
	}
}
