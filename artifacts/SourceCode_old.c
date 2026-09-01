extern int __VERIFIER_nondet_int(void);
int main(void) {
    int x = __VERIFIER_nondet_int();
    int seed = __VERIFIER_nondet_int();
    int outer_mode = __VERIFIER_nondet_int();
    int inner_mode = __VERIFIER_nondet_int();
    if (x < 0) {
        x = 6;
    }
    if (x > 10) {
        x = 10;
    }
    while (x > 0) {
        if (x == 9) {
            return 11;
        }
        if (x == 7) {
            break;
        }
        x = x - 1;
        if (x == 5) {
            continue;
        }
        x = x - 1;
    }
    if (seed < 0) {
        seed = 0;
    }
    if (seed > 10) {
        seed = 10;
    }
    int n = seed;
    int y = 0;
    while (n >= 0) {
        if (n == 10) {
            n = 4;
            continue;
        }
        if (n == 8) {
            return 22;
        }
        if (n == 6) {
            break;
        }
        y = n + 2;
        while (y > 0) {
            if (y == 7) {
                return 33;
            }
            if (y == 5) {
                break;
            }
            if (inner_mode == 0 && y == 2) {
                continue;
            }
            y = y - 1;
            if (y == 3) {
                continue;
            }
        }
        if (outer_mode == 0 && n == 2) {
            continue;
        }
        n = n - 1;
    }
    return 0;
}