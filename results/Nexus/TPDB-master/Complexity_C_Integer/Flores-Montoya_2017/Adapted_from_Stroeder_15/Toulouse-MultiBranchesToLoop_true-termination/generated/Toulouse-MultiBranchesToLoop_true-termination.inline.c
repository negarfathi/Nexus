extern int __VERIFIER_nondet_int(void);

int foo(int x,int y,int z){
if (__VERIFIER_nondet_int() != 0) {
        x = 1;
    } else {
        x = -1;
    }
if (x > 0) {
        x = x + 1;
    } else {
        x = x - 1;
    }
if (x > 0) {
        x = x + 1;
    } else {
        x = x - 1;
    }
if (x > 0) {
        x = x + 1;
    } else {
        x = x - 1;
    }
if (x > 0) {
        x = x + 1;
    } else {
        x = x - 1;
    }
if (x > 0) {
        x = x + 1;
    } else {
        x = x - 1;
    }
if (x > 0) {
        x = x + 1;
    } else {
        x = x - 1;
    }
if (x > 0) {
        x = x + 1;
    } else {
        x = x - 1;
    }
if (x > 0) {
        x = x + 1;
    } else {
        x = x - 1;
    }
while (y<100 && z<100) { __asm__ __volatile__("# NEXUS_SOURCE_LOOP_ID_1_PARENT_0" ::: "memory"); 
        y = y+x;
        z = z-x;
    }
{ __asm__ __volatile__("# NEXUS_SOURCE_RETURN_DEPTH_0_IDS_NONE" ::: "memory"); return 0; }
}

