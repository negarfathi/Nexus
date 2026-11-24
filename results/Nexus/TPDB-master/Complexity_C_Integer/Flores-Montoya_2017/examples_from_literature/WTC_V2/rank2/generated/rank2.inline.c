

int nondet();

void rank2(int m)
{
int x=m;
int y=m;
while(x>=2) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
x--; y = y+x;
while(y>=x && nondet()>0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); y--; }
x--; y = y-x;
}
}


