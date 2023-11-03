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
    // constantly display command prompt
    write(2, ">>> ", 4);

    // read input from user
    // gets(buffer, bufferSize);
    read(0, buffer, bufferSize);


    // if the user just presses enter, exit function (this is so it is called again in the while loop so that the command prompt will be printed agaim)
    if (strlen(buffer) == 1)
    {
        write(2, "\n", 2);
        return 0;
    }

    // if we read in a < or > and \n then checkRedirection will be equal to 1.
    // if we only read in a \n then status = 0
    // initialize to 0 for now
    int checkLineStatus = 0;
    
    
    
    // for loop to replace the newline character and replace it with a null-terminating character
    // once 1 has been returned, this is an indication to the main function that the line has been read and processed, so now it is ready to be formatted to execute
    for (int i=0; i<bufferSize; i++)
    {
        if(buffer[i] == '<' || buffer[i] == '>')
        {
            checkLineStatus = 1;
        }

        if (buffer[i] == '\n')
        {
            buffer[i] = '\0';
            break;
            
        }
    }
    return checkLineStatus;
}

/*
the function separateRedirection will : 
    - detect the presence of < or > .
    - if < then set redirectionStatus to 1.
    - if > then set to 2.
    - 
*/
int
separateRedirection(char *buffer, char *args[], char *redirectionFile , const int bufSize, int redirectionStatus)
{
    // iterate through buffer and when we reach the < or > characters we set the pointer to this index.
    // replace < or > with null terminating character

    int i;
    for (i=0; i < bufSize; i++)
    {
        if (buffer[i] == ' ')
        {
            continue;
        }
        
        if (buffer[i] == '<' || buffer[i] == '>')
        {
            redirectionStatus = (buffer[i] == '<') ? 1 : 2;
            buffer[i] = '\0';
            break; // we have found the index where the < or > operators start, break from loop

        }  
    }

    if (i < bufSize)
    {
        int j = 0;
        for (i++; i<bufSize && buffer[i] != '\0'; i++, j++)
        {
            redirectionFile[j] = buffer[i];
        }     
        redirectionFile[j] = '\0';
    } else 
    {
        redirectionFile[0] = '\0';
        redirectionStatus = 0;
    }

    return redirectionStatus;
}

/*

this function formatLine will:
    - create a new process 
    - separate the buffer into seperate strings 
    - store these strings in the argument array 
    - execute the command with its arguments

the function will also handle redirection depending on the redirectionStatus. (Remember if 0, then no redirection. If 1, then we need to handle < . If 2, we need to handle > . )
    - the function handles redirectioin using the dup() function
    - by changing the values of file descriptors, we can manipulate input and output
    - file descriptors then have to be restored back to STDIN and STDOUT before we read our next line
*/
// function to change directory
int
handlecd(char *args[])
{
    int dirCheck  = chdir(args[1]);
    
    if(dirCheck < 0)
    {   
        printf("cd error : exiting");
        exit(1);
    }
    return 0;
}

void
formatLine(char *buffer, char *args[], char *redirectionFile, int redirectionStatus)
{

    // create a new process 
    int pid = fork();

    // verify fork has worked
    if (pid < 0)
    {
        printf("Fork failed");
        exit(1);

    } else if(pid == 0) // verify that we are in the child process
    {
        // wordstart is a variable that we will use to indicate the beginning and end of a word
        // when we meet the first letter of the word, worstart = 0.
        // when we meet the first blankspace after the word, wordstart = 1
        // repeat with next word
        int wordstart = 1;

        // pointers we will use to traverse the buffer and argument arrays.
        char **argumentPointer, *bufferPointer;


        // set argument pointer to start of argument array
        argumentPointer = &args[0];

        // set buffer pointer to start of buffer array 
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
                
                    // ***** SECTION 1 ***** //

                    *argumentPointer = bufferPointer;
                    wordstart = 0;
                }
            }   else 
            {
                if (!wordstart) 
                {

                    // ***** SECTION 2 ***** //

                    *bufferPointer = '\0';

                    argumentPointer++;

                    wordstart = 1;
                }
            }

        bufferPointer++;
        }

        // redirection handling
        if (redirectionStatus > 0)
        {
        
            if (redirectionStatus == 1)
            {
                // open redirection file in read only mode. this will be stored in next avaliable fd.
                int fileDescriptor = open(redirectionFile, O_RDONLY);

                if (fileDescriptor == -1)
                {
                    printf("File open error : exiting");
                    exit(1);
                } 

                // duplicate the standard input file descriptor. this will be stored in the next avaliable fd.
                // this is done so we can restore it later  
                int STDIN_fileDescriptor = dup(0);

                close(0);

                // close the original STDIN file descriptor. this will now become free to use. 
                // close(0)strncmpcate our file that we have opened. because we closed file descriptor 0, this will be stored there as it is free. 
                int result = dup(fileDescriptor);

                // we can now close our old copy
                close(fileDescriptor);

                // verify dup worked
                if (result < 0)
                {
                    printf("Dup error : exiting");
                    exit(1);
                }

                // execute as normal. because we have changed STDIN to our file, any input should come from out file now 
                exec(args[0], args);

                // now we can close our file descriptor as we need to restore STDIN
                close(0);

                // file descriptor 0 is free, so now lets dup our copy that we saved earlier and it will store it in fd 0. we can then close our copy.
                dup(STDIN_fileDescriptor);
                close(STDIN_fileDescriptor);
            
            }
            else if (redirectionStatus == 2)
            {
                 // open redirection file in required modes. this will be stored in next avaliable fd.
                int fileDescriptor = open(redirectionFile, O_WRONLY | O_CREATE | O_TRUNC); 
                
                if (fileDescriptor == -1)
                {
                    printf("File open error : exiting");
                    exit(1);
                }

                // duplicate the standard output file descriptor. this will be stored in the next avaliable fd.
                // this is done so we can restore it later
                int STDOUT_fileDescriptor = dup(1);

                // close the original STDOUT file descriptor. this will now become free to use. 
                close(1);

                // duplicate our file that we have opened. because we closed file descriptor 1, this will be stored there as it is free. 
                int result = dup(fileDescriptor);

                //close our old copy
                close(fileDescriptor);

                // verify dup worled
                if (result < 0)
                {
                    printf("Dup error : exiting");
                    exit(1);
                }

                
                // execute as normal. because we have changed STDOUT to our file, any output should go to our file now 
                

                if(exec(args[0], args) < 0)
                {
                    printf("Exec error : exiting\n");
                    exit(1);
                }

                // now we can close our file descriptor as we need to restore STDOUT
                close(1);

                // file descriptor 1 is free, so now lets dup our copy that we saved earlier and it will store it in fd 1. we can then close our copy.
                dup(STDOUT_fileDescriptor);
                close(STDOUT_fileDescriptor);
            } 
        }
        else 
        {   
            char cd[] = "cd";
            
            if (strcmp(args[0], cd) == 0)
            {
                handlecd(args);
            }
            
            // execute commands 
            else if(exec(args[0], args) < 0)
            {
                printf("Exec error : exiting\n");
                exit(1);
            }
        }      

    } else // parent waits for child
    {
        wait(0);
    }    
}

// function to remove leading spaces from extracted fileName
void
removeLeadingSpaces(char *file, char *newFile)
{
    int i = 0;

    while (file[i] == ' ' || file[i] == '\t' || file[i] == '\n')
    {
        i++;
    }

    int k = 0;

    for(int j = i; file[j] != '\0'; j++)
    {
        newFile[k] = file[j];
        k++;
    }
    newFile[k] = '\0';  
}

int 
main(int argc, char *argv[]) 
{
    // declare constant variables outside of loop 
    const int BUFSIZE = 512;


    // display command prompt indefinitely 
    while (1)
    {
        // create a buffer that we will read into and declare a constant size
        char buffer[BUFSIZE];    
        char newBuffer[BUFSIZE];    


        // initialize argument array that will store arguments after tokenized
        // set all elements to null
        char* args[MAXARG] = { 0 };

        // create array to store any redirection files into if any.
        char redirectionFile[512] = { 0 };
        
        // create another array which will be used to store the redirection file with no leading spaces 
        char newRedirectionFile[512] = { 0 };

        // redirections status used to tell us if we need to redirect or not
        int redirectionStatus = 0;
        
        
        // readLine will return 1 when it replaces the newline character with a null terminating character
        // once this is done, it means that the line read is now ready to be formatted to execute #
        // readLine will return 2 when it replaces \n AND it has a < or > operator 
        int readLineStatus = 0;
        readLineStatus = readLine(buffer, BUFSIZE);

        removeLeadingSpaces(buffer, newBuffer);
 
        // redirection not needed, carry on as normal 
        if (readLineStatus == 0)
        {
            formatLine(newBuffer, args, redirectionFile, redirectionStatus);
           
        }
        //redirection needed, extract filename from buffer, remove leading spaces and then format the rest of the buffer ready for execution
        else if (readLineStatus == 1)
        {
            int separatedRedirection = separateRedirection(newBuffer, args, redirectionFile, BUFSIZE, redirectionStatus);

            removeLeadingSpaces(redirectionFile, newRedirectionFile);

            formatLine(newBuffer, args, newRedirectionFile, separatedRedirection);
           
        }
        else 
        {
            printf("readLine error");
        }

    }
    return 0;
}