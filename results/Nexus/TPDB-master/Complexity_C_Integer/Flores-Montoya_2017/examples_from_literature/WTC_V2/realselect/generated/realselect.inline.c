
int nondet();

void realselect(int array_size)//int numbers[])
{
  int i, j;
  int min, temp;

  for (i = 0; i < array_size-1; i++)
  { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
    min = i;
    for (j = i+1; j < array_size; j++)
    { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
      if (nondet() < nondet())
        min = j;
    }
    ;
    //temp = numbers[i];
    //numbers[i] = numbers[min];
    //numbers[min] = temp;
  }
}
