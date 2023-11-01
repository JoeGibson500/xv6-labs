#include "kernel/types.h"
#include "user/user.h"
#include "kernel/fcntl.h"
#include "kernel/param.h"


/*
the function readLine will :
    - print the command prompt
    - read in user input 
    - return 1 when it has replaced the newline character with \0
*/
int
readLine(char buffer[], const int bufferSize)
{
    //constantly display command prompt
    write(2, ">>> ", 4);

    //read input from user
    gets(buffer, bufferSize);


    //if the user just presses enter, exit function (this is so it is called again in the while loop so that the command prompt will be printed agaim)
    if (strlen(buffer) == 1)
    {
        write(2, "\n", 2);
        return 0;
    }

    //if we read in a < or > and \n then checkRedirection will be equal to 2.
    //if we only read in a \n then status = 1
    //initialize to 0 for now
    int checkRedirection = 0;
    
    
    //for loop to replace the newline character and replace it with a null-terminating character
    //once 1 has been returned, this is an indication to the main function that the line has been read and processed, so now it is ready to be formatted to execute
    for (int i=0; i<bufferSize; i++)
    {
        if(buffer[i] == '<' || buffer[i] == '>')
        {
            checkRedirection += 1;
        }

        if (buffer[i] == '\n')
        {
            buffer[i] = '\0';

            checkRedirection += 1;
            
        }
    }
    return checkRedirection;
}

void 
separateRedirection(char *buffer, char *args[], char *redirectionFile , const int bufSize, int redirectionStatus)
{

    redirectionFile[0] = '\0';

    //  declare pointers to redirectionFile section
    char *inputRedirection = buffer;
    char *outputRedirection = buffer;

    //iterate through buffer and when we reach the < or > characters we set the pointer to this index.
    //replace < or > with null terminating character
    for (int i=0; i<bufSize; i++)
    {
        if (buffer[i] == '<')
        {
            inputRedirection = &buffer[i];
            
            *inputRedirection = '\0';

        } else if (buffer[i] == '>')
        {
            outputRedirection = &buffer[i];

            *outputRedirection = '\0';
        } 
    }

    if (inputRedirection != &buffer[0] )
    {
        //extract the input filename 
        //inputRedirection - buffer + 1 will set the index i to the space after the < or > operator
        //we can then iterate after this storing whatever comes after in the redirectionFile array
        int j = 0;
        for (int i = inputRedirection - buffer + 1; buffer[i] != '\0' && buffer[i] != ' '; i++, j++)
        {
            redirectionFile[j] = buffer[i];
            redirectionStatus = 1;

        }
    }

     if (outputRedirection != &buffer[0])
    {
        //extract the output filename 
        //outputRedirection - buffer + 1 will set the index i to the space after the < or > operator
        //we can then iterate after this storing whatever comes after in the redirectionFile array
        int j = 0;
        for (int i = outputRedirection - buffer + 1; buffer[i] != '\0' && buffer[i] != ' '; i++, j++)
        {
            redirectionFile[j] = buffer[i];
            redirectionStatus = 2;
        }
    }   
}


/*

this function formatLine will:
    - create a new process 
    - separate the buffer into seperate strings 
    - store these strings in the argument array 
    - execute the command with its arguments
*/
void
formatLine(char *buffer, char *args[], char *redirectionFile, int redirectionStatus)
{

    //create a new process 
    int pid = fork();

    //verify fork has worked
    if (pid < 0)
    {
        printf("Fork failed");
        exit(1);

    } else if(pid == 0) // verify that we are in the child process
    {
        //wordstart is a variable that we will use to indicate the beginning and end of a word
        //when we meet the first letter of the word, worstart = 0.
        //when we meet the first blankspace after the word, wordstart = 1
        //repeat with next word
        int wordstart = 1;

        //pointers we will use to traverse the buffer and argument arrays.
        char **argumentPointer, *bufferPointer;


        //set argument pointer to start of argument array
        argumentPointer = &args[0];

        //set buffer pointer to start of buffer array 
        bufferPointer = buffer;

        /*
        If the bufferpointer is not pointing at a null-terminating character, it will continue
        This while loop has two sections to it:
            SECTION 1: If we meet a character and wordstart is set to 1:
                - If this happens then that means that a new word has started.
                - We should assign its address to the first element of the argument array
                - Set wordstart equals as word has now started

            SECTION 2: If we meet a character and wordstart is set to 0:
                - This means we have reached the end of the word
                - We should replace the current space with a nul-terminating character
                - We should move to the next element in the argument array by incrementing the argument pointer.
                - We should set wordstart back to 1 as the next character to be read will be the start of a new word


        Finally, at the end of the loop we should increment bufferPointer. Once we reach a null-terminating character, we should break out the loop and use exec to run our command 
        */
        while (*bufferPointer != '\0') {
            if (*bufferPointer != ' ') 
            {
                if (wordstart)
                {
                
                    // ***** SECTION 1 *****//

                    *argumentPointer = bufferPointer;
                    wordstart = 0;
                }
            }   else 
            {
                if (!wordstart) 
                {

                    //***** SECTION 2 *****//

                    *bufferPointer = '\0';

                    argumentPointer++;

                    wordstart = 1;
                }
            }

        bufferPointer++;
        }

        if(redirectionFile[0] != '\0')
        {
            if (redirectionStatus == 1)
            {
                //open redirection file in read only mode
                int fd = open(redirectionFile, O_RDONLY);
                //verify we have read in correctly
                if (fd == -1)
                {
                printf("file open error : exiting");
                exit(1);
                }


                // ***************CHANGE TO DUP******************
                //set file descriptor 1 to be our redirectionFile instead of STDIN
                dup2(fd,0);


                //close original file descriptor as no longer needed
                close(fd);

       
            } else if (redirectionStatus == 2)
            {
                //open redirection file in write mode, if the file does not exist it should create it, if the file exists, it size should be truncated to zero
                //0644 = specifies file permissions for newly created file.

                int fd = open(redirectionFile, O_WRONLY | O_CREATE | O_TRUNC);
                //verify we have read in correctly
                if (fd == -1)
                {
                printf("file open error : exiting");
                exit(1);
                }

                //set file descriptor 1 to be our redirectionFile instead of STDIN
                dup2(fd, 1);
                //close original file descriptor as no longer needed
                close(fd);
            } 
        } 


        //execute commands 
        exec(args[0], args);
        

    } else //parent waits for child
        wait(0);
}

//function to change directory
void
cd(char *path)
{
    if(chdir(path) < 0)
    {       // At this point args stores pointers to the original
        // command passed to xargs plus pointers to any inputs from
        // the standard input. Execute the command.
    }
}
int 
main(int argc, char *argv[]) 
{

    //create a buffer that we will read into and declare a constant size
    const int BUFSIZE = 512;
    char buffer[BUFSIZE];    

    //initialize argument array that will store arguments after tokenized
    //set all elements to null
    char* args[MAXARG] = { 0 };

    //create array to store any redirection files into if any.
    char redirectionFile[512] = { 0 };
    int redirectionStatus = 0;

    //display command prompt indefinitely 
    while (1)
    {
        //readLine will return 1 when it replaces the newline character with a null terminating character
        //once this is done, it means that the line read is now ready to be formatted to execute #
        //readLine will return 2 when it replaces \n AND it has a < or > operator 
        if (readLine(buffer, BUFSIZE) == 1)
        {
            formatLine(buffer, args, redirectionFile, redirectionStatus);
        }
        else if (readLine(buffer, BUFSIZE) == 2)
        {

            separateRedirection(buffer, args, redirectionFile, BUFSIZE, redirectionStatus);
            formatLine(buffer, args, redirectionFile, redirectionStatus);
        }

    }

    //special case for cd.
    if(buffer[0] == 'c' && buffer[1] == 'd' && buffer[2] == ' ')
    {
        char *path = buffer + 3; // skip cd and get the directory path
        cd(path);
 
    }

    return 0;
}