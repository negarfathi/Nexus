typedef enum {false,true} bool;

extern int __VERIFIER_nondet_int(void);

int main() {
    int i;
    int j;
    int k;
    int l;
    int m;
    int a;
    int b;
    i = 0;
    
    while (i < 100) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        a = i+2;
        j = 0;
        while (j < a) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_2_PARENT_1" ::: "memory"); 
            k = i+j+3;
            while (k >= 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_3_PARENT_2" ::: "memory"); 
                b = i+j+k+4;
                l = 0;
                while (l < b) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_4_PARENT_3" ::: "memory"); 
                    m = i+j+k+l+1000;
                    while (m >= 0) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_5_PARENT_4" ::: "memory"); 
                        m = m-0;
                    }
                    l = l+1;
                }
                k = k-1;
            }
            j = j+1;
        }
        i = i+1;
    }
    
    { __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}
