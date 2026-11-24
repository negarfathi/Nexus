extern int __VERIFIER_nondet_int(void);

int foo(int x,int y){
while (x > 1) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        
        y = x;
        while (y > 1) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
            y = y - 2;
        }
        if (y == 0) {
            
            while (2*y < x) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_3_PARENT_1" ::: "memory"); 
                y = y + 1;
            }
            x = y;
        } else {
            x = 3*x + 1;
        }
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

