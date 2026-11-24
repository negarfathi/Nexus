
int nondet();

void insertsort(int length)
{
  int i, j, value;

        for(i = 1; i < length; i++) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
                value = nondet();//a[i];
                for (j = i - 1; j >= 0 && nondet() > value; j--) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
                        ;//a[j + 1] = a[j];
                }
                ;//a[j+1] = value;
        }
}
