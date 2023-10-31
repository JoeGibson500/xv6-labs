#include "kernel/types.h"
#include "user/user.h"

int main(void) {
    fprintf(1, "Note: UNIX V6 was released in year %d\n", getyear());
    
    return 0;
}