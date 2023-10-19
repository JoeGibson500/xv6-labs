#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"



int main( int argc, char* argv[]) {
	
	//check arguments are correct
	if (argc != 2) {
		printf("Argument error");
		return 1;
	
	}

	//create two integer array to represent return and send pipes, and use pipe() 
	int sendPipe[2];
	int returnPipe[2];
	
	pipe(sendPipe);
	pipe(returnPipe);


	//set the first argument to be our byte that we will be sending
	char byte = argv[1][0];
	char alteredByte;
	
        //create new process
        int PID = fork();

	if ( PID < 0) {
		printf("pipe error");
		close(sendPipe[0]);
		close(sendPipe[1]);
		close(returnPipe[0]);
		close(returnPipe[1]);

		return 1;
	}	

	
	//check current process is parent process
	if ( PID > 0 ) {
		
		//send byte to child process
		write(sendPipe[1], &byte, 1);
       		
		
		close(sendPipe[1]);

		//wait for child process to finish
		wait(0);	
		
		//read in the altered byte 
		read(returnPipe[0], &alteredByte, 1);


	        printf("%d: Received Pong ,%c\n",getpid(), alteredByte);


		close(returnPipe[0]);	

		exit(0);
	}
	//check current process is child process
        else if(PID == 0) {
		
		//read byte sent from parent
		read(sendPipe[0], &byte, 1);
       		
		close(sendPipe[0]);	

		//alter byte
		alteredByte = byte >> 2;

	        printf("%d: Received ping, %c\n",getpid(), byte);


		//send altered byte back to parent
		write(returnPipe[1], &alteredByte, 1);
 
		close(returnPipe[1]);


		exit(0);	
		
		
	}
	return 0;
}	



