#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>


int main (int argc, char *argv[]) {
	if (argc !=2 ) {
		printf("Error, incorrect arguments");
		return 1;
	}
	
	//convert 1st argument to an integer as it is passed as a string 
	int timeOfSleep = atoi(argv[1]);
	
	//sleep for required amount of time
	sleep(timeOfSleep);

	exit(0);
}	
